import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './users/users.module';
import { BrutesModule } from './brutes/brutes.module';
import { AchievementsModule } from './achievements/achievements.module';
import { User } from './users/entities/user.entity';
import { Brute } from './brutes/entities/brute.entity';
import { Achievement } from './achievements/entities/achievement.entity';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.POSTGRES_HOST,
      port: +process.env.POSTGRES_PORT,
      username: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DB,
      entities: [User, Brute, Achievement],
    }),
    UsersModule,
    BrutesModule,
    AchievementsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
