import { Module } from '@nestjs/common';
import { AchievementsService } from './achievements.service';
import { AchievementsController } from './achievements.controller';
import { Achievement } from './entities/achievement.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Achievement])],
  controllers: [AchievementsController],
  providers: [AchievementsService],
  exports: [TypeOrmModule, AchievementsService],
})
export class AchievementsModule {}
