import { Test, TestingModule } from '@nestjs/testing';
import { BrutesController } from './brutes.controller';
import { BrutesService } from './brutes.service';

describe('BrutesController', () => {
  let controller: BrutesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [BrutesController],
      providers: [
        BrutesService,
        {
          provide: BrutesService,
          useValue: {
            getAll: jest.fn().mockResolvedValue([]),
          },
        },
      ],
    }).compile();

    controller = module.get<BrutesController>(BrutesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
