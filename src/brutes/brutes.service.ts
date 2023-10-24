import { Injectable } from '@nestjs/common';
import { CreateBruteDto } from './dto/create-brute.dto';
import { UpdateBruteDto } from './dto/update-brute.dto';

@Injectable()
export class BrutesService {
  create(createBruteDto: CreateBruteDto) {
    return 'This action adds a new brute';
  }

  findAll() {
    return `This action returns all brutes`;
  }

  findOne(id: number) {
    return `This action returns a #${id} brute`;
  }

  update(id: number, updateBruteDto: UpdateBruteDto) {
    return `This action updates a #${id} brute`;
  }

  remove(id: number) {
    return `This action removes a #${id} brute`;
  }
}
