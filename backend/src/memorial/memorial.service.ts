import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Memorial } from 'src/entitiies/memorial.entity';
import { User } from 'src/entitiies/user.entity';
import { Repository } from 'typeorm';
import { CreateMemorialDto } from './dto/create.memorial.dto';

@Injectable()
export class MemorialService {
  constructor(
    @InjectRepository(Memorial)
    private readonly memorialRepository: Repository<Memorial>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async postMemorial(userId: string, data: CreateMemorialDto) {
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
    });

    return this.memorialRepository.save(memorial);
  }

  getMemorialsByUser(userId) {
    return this.memorialRepository.find({
      where: {
        user: userId,
      },
    });
  }

  getMemorialsByUserAndMemorialId(userId, memorialId) {
    return this.memorialRepository.findOne({
      where: {
        user: userId,
        id: memorialId,
      },
    });
  }
}
