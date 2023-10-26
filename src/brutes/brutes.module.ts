import { Module } from '@nestjs/common';
import { BrutesService } from './brutes.service';
import { BrutesController } from './brutes.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Brute } from './entities/brute.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Brute])],
  controllers: [BrutesController],
  providers: [BrutesService],
  exports: [TypeOrmModule, BrutesService],
})
export class BrutesModule {}
