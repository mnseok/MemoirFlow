import { Body, Controller, Post } from '@nestjs/common';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AuthService } from 'src/auth/auth.service';
import { LoginRequestDto } from 'src/auth/dto/login.request.dto';
import { SingupRequestDto } from './dto/signup.request.dto';
import { GithubCodeDto } from 'src/common/dto/user.dto';

@ApiTags('User')
@Controller('user')
export class UserController {
  constructor(
    private readonly userService: UserService,
    private readonly authService: AuthService,
  ) {}

  @ApiOperation({ summary: '회원가입' })
  @Post('signup')
  signUp(@Body() data: SingupRequestDto) {
    return this.userService.signUp(data);
  }

  @ApiOperation({ summary: '로그인' })
  @Post('login')
  logIn(@Body() data: LoginRequestDto) {
    return this.authService.jwtLogin(data);
  }

  @Post('/github-info')
  public async getGithubInfo(@Body() githubCodeDto: GithubCodeDto) {
    const user = await this.userService.getGithubInfo(githubCodeDto);

    return {
      status: 200,
      message: '깃허브 유저 정보를 조회하였습니다.',
      data: {
        user,
      },
    };
  }
}
