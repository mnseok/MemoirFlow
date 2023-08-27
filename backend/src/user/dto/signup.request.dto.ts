import { PickType } from '@nestjs/swagger';
import { User } from 'src/entitiies/user.entity';

export class SingupRequestDto extends PickType(User, [
  'email',
  'nickname',
  'password',
]) {}
