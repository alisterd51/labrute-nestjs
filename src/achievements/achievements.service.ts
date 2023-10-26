import { Injectable } from '@nestjs/common';
import { CreateAchievementDto } from './dto/create-achievement.dto';
import { UpdateAchievementDto } from './dto/update-achievement.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Achievement } from './entities/achievement.entity';
import {
  DeleteResult,
  FindOneOptions,
  Repository,
  UpdateResult,
} from 'typeorm';

@Injectable()
export class AchievementsService {
  constructor(
    @InjectRepository(Achievement)
    private achievementsRepository: Repository<Achievement>,
  ) {}

  create(createAchievementDto: CreateAchievementDto): Promise<Achievement> {
    const achievement =
      this.achievementsRepository.create(createAchievementDto);
    return this.achievementsRepository.save(achievement);
  }

  findAll(): Promise<Achievement[]> {
    return this.achievementsRepository.find();
  }

  findOne(where: FindOneOptions<Achievement>): Promise<Achievement | null> {
    return this.achievementsRepository.findOne(where);
  }

  update(
    id: number,
    updateAchievementDto: UpdateAchievementDto,
  ): Promise<UpdateResult> {
    return this.achievementsRepository.update({ id }, updateAchievementDto);
  }

  remove(id: number): Promise<DeleteResult> {
    return this.achievementsRepository.delete(id);
  }
}
