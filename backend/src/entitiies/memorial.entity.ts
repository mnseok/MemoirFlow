import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';
import { Time } from 'src/common/types/time.type';
import { CustomDate } from 'src/common/types/customDate.type';

@Entity('memorial')
export class Memorial {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  content: string;

  @Column({ nullable: true })
  imageUrl: string;

  @Column('date')
  date: CustomDate;

  @Column('varchar')
  time: Time;

  @ManyToOne(() => User, (user) => user.memorials)
  user: User;
}
