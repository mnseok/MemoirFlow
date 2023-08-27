import { PickType } from '@nestjs/mapped-types';
import { User } from 'src/entitiies/user.entity';

export class LoginRequestDto extends PickType(User, [
  'email',
  'password',
] as const) {}
