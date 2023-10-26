import { Test, TestingModule } from '@nestjs/testing';
import { BrutesService } from './brutes.service';

describe('BrutesService', () => {
  let service: BrutesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
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

    service = module.get<BrutesService>(BrutesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
