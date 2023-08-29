import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Memorial } from 'src/entitiies/memorial.entity';
import { MemorialController } from './memorial.controller';
import { MemorialService } from './memorial.service';
import { User } from 'src/entitiies/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Memorial, User])],
  controllers: [MemorialController],
  providers: [MemorialService],
})
export class MemorialModule {}
