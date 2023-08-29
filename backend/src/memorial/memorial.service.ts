import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Memorial } from 'src/entitiies/memorial.entity';
import { User } from 'src/entitiies/user.entity';
import { Repository } from 'typeorm';
import { CreateMemorialDto } from './dto/create.memorial.dto';
import { CustomDate } from 'src/common/types/customDate.type';

@Injectable()
export class MemorialService {
  constructor(
    @InjectRepository(Memorial)
    private readonly memorialRepository: Repository<Memorial>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async postMemorial(
    userId: string,
    data: CreateMemorialDto,
    date: CustomDate,
  ) {
    const user = await this.userRepository
      .createQueryBuilder('user')
      .where('user.id = :userId', { userId })
      .getOne();
    if (!user) {
      throw new NotFoundException('User not found');
    }

    const memorial = this.memorialRepository.create({
      ...data,
      user,
      date,
    });

    return this.memorialRepository.save(memorial);
  }

  getMemorialsByUser(userId: string, date: CustomDate) {
    return this.memorialRepository.find({
      where: {
        date,
        user: { id: userId },
      },
    });
  }

  getMemorialsByUserAndMemorialId(memorialId: string) {
    return this.memorialRepository.findOne({
      where: {
        id: memorialId,
      },
    });
  }

  async updateMemorial(memorialId: string, data: CreateMemorialDto) {
    const memorial = await this.memorialRepository.findOne({
      where: {
        id: memorialId,
      },
    });
    if (!memorial) {
      throw new NotFoundException('Memorial not found');
    }

    memorial.content = data.content;
    return this.memorialRepository.save(memorial);
  }
}
