import {
  HttpException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entitiies/user.entity';
import { Repository } from 'typeorm';
import { SingupRequestDto } from './dto/signup.request.dto';
import * as bcrypt from 'bcrypt';
import { GithubCodeDto } from 'src/common/dto/user.dto';
import * as dotenv from 'dotenv';
import axios, { AxiosResponse } from 'axios';
dotenv.config();

export interface IGithubUserTypes {
  githubId: string;
  avatar: string;
  name: string;
  description: string;
  location: string;
}

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}
  async signUp(data: SingupRequestDto) {
    const { email, password, nickname } = data;
    const isExist = await this.userRepository
      .createQueryBuilder('user')
      .where('user.email = :email', { email })
      .getOne();
    if (isExist) {
      throw new UnauthorizedException('이미 존재하는 이메일입니다.');
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const user = this.userRepository.create({
      email,
      password: hashedPassword,
      nickname,
    });
    await this.userRepository.save(user);
    const { password: _password, ...userData } = user;
    return userData;
  }

  public async getGithubInfo(
    githubCodeDto: GithubCodeDto,
  ): Promise<IGithubUserTypes> {
    const { code } = githubCodeDto;
    // 웹에서 query string으로 받은 code를 서버로 넘겨 받습니다.

    const getTokenUrl = 'https://github.com/login/oauth/access_token';
    // 깃허브 access token을 얻기위한 요청 API 주소

    const request = {
      code,
      client_id: process.env.GH_CLIENT_ID,
      client_secret: process.env.GH_CLIENT_SECRET,
    };
    // Body에는 Client ID, Client Secret, 웹에서 query string으로 받은 code를 넣어서 전달해주어야 합니다.

    const response: AxiosResponse = await axios.post(getTokenUrl, request, {
      headers: {
        accept: 'application/json', // json으로 반환을 요청합니다.
      },
    });

    if (response.data.error) {
      // 에러 발생시
      throw new UnauthorizedException('깃허브 인증을 실패했습니다.');
    }

    const { access_token } = response.data;
    // 요청이 성공한다면, access_token 키값의 토큰을 깃허브에서 넘겨줍니다.

    const getUserUrl = 'https://api.github.com/user';
    // 깃허브 유저 조회 API 주소

    const { data } = await axios.get(getUserUrl, {
      headers: {
        Authorization: `token ${access_token}`,
      },
      // 헤더에는 `token ${access_token} 형식으로 넣어주어야 합니다.`
    });

    const { login, avatar_url, name, bio, company } = data;
    // 깃허브 유저 조회 API에서 받은 데이터들을 골라서 처리해줍니다.

    const githubInfo: IGithubUserTypes = {
      githubId: login,
      avatar: avatar_url,
      name,
      description: bio,
      location: company,
    };

    return githubInfo;
  }
}
