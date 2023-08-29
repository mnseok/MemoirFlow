import { IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { Time } from 'src/common/types/time.type';

export class CreateMemorialDto {
  @IsNotEmpty()
  @IsString()
  date: Date;

  @IsNotEmpty()
  @IsString()
  time: Time;

  @IsNotEmpty()
  @IsString()
  content: string;

  @IsOptional()
  @IsString()
  imageUrl: string;
}
