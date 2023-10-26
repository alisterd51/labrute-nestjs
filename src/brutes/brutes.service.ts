import { Injectable } from '@nestjs/common';
import { CreateBruteDto } from './dto/create-brute.dto';
import { UpdateBruteDto } from './dto/update-brute.dto';
import { Brute } from './entities/brute.entity';
import {
  DeleteResult,
  FindOneOptions,
  Repository,
  UpdateResult,
} from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class BrutesService {
  constructor(
    @InjectRepository(Brute)
    private brutesRepository: Repository<Brute>,
  ) {}

  create(createBruteDto: CreateBruteDto): Promise<Brute> {
    const brute = this.brutesRepository.create(createBruteDto);
    return this.brutesRepository.save(brute);
  }

  findAll(): Promise<Brute[]> {
    return this.brutesRepository.find();
  }

  findOne(where: FindOneOptions<Brute>): Promise<Brute | null> {
    return this.brutesRepository.findOne(where);
  }

  update(id: number, updateBruteDto: UpdateBruteDto): Promise<UpdateResult> {
    return this.brutesRepository.update({ id }, updateBruteDto);
  }

  remove(id: number): Promise<DeleteResult> {
    return this.brutesRepository.delete(id);
  }
}
