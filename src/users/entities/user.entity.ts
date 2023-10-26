import { Achievement } from 'src/achievements/entities/achievement.entity';
import { Brute } from 'src/brutes/entities/brute.entity';
import {
  Column,
  Entity,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

export enum Lang {
  FR,
  EN,
}

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ default: Lang.FR })
  lang: Lang;

  @Column({ default: 3 })
  bruteLimit: number;

  @Column({ default: true })
  backgroundMusic: boolean;

  @OneToMany(() => Brute, (brute) => brute.user)
  brutes: Brute[];

  @ManyToMany(() => Achievement, (achievement) => achievement.users)
  achievements: Achievement[];
}
