import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { BrutesService } from './brutes.service';
import { CreateBruteDto } from './dto/create-brute.dto';
import { UpdateBruteDto } from './dto/update-brute.dto';

@Controller('brutes')
export class BrutesController {
  constructor(private readonly brutesService: BrutesService) {}

  @Post()
  create(@Body() createBruteDto: CreateBruteDto) {
    return this.brutesService.create(createBruteDto);
  }

  @Get()
  findAll() {
    return this.brutesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.brutesService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateBruteDto: UpdateBruteDto) {
    return this.brutesService.update(+id, updateBruteDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.brutesService.remove(+id);
  }
}
