import { PartialType } from '@nestjs/mapped-types';
import { CreateBruteDto } from './create-brute.dto';

export class UpdateBruteDto extends PartialType(CreateBruteDto) {}
