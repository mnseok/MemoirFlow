import { Module, forwardRef } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/entitiies/user.entity';
import { AuthModule } from 'src/auth/auth.module';
import { Memorial } from 'src/entitiies/memorial.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, Memorial]),
    forwardRef(() => AuthModule),
  ],
  providers: [UserService],
  controllers: [UserController],
})
export class UserModule {}
