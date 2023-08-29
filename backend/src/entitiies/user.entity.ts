import { IsEmail, IsNotEmpty, IsString } from 'class-validator';
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { Memorial } from './memorial.entity';

@Entity('user')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ length: 50 })
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @Column()
  @IsNotEmpty()
  @IsString()
  password: string;

  @Column({ length: 50 })
  @IsNotEmpty()
  @IsString()
  nickname: string;

  @OneToMany(() => Memorial, (memorial) => memorial.user)
  memorials: Memorial[];
}
