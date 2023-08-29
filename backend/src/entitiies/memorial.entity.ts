import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';
import { Time } from 'src/common/types/time.type';

@Entity('memorial')
export class Memorial {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  content: string;

  @Column({ nullable: true })
  imageUrl: string;

  @Column('varchar')
  time: Time;

  @ManyToOne(() => User, (user) => user.memorials)
  user: User;
}
