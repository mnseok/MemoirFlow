import { Time } from './time.type';

export type CustomDate = {
  year: number;
  month: number;
  day?: number;
  time?: Time;
};
