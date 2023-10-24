import { Module } from '@nestjs/common';
import { BrutesService } from './brutes.service';
import { BrutesController } from './brutes.controller';

@Module({
  controllers: [BrutesController],
  providers: [BrutesService],
})
export class BrutesModule {}
