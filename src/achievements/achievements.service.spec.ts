import { Test, TestingModule } from '@nestjs/testing';
import { AchievementsService } from './achievements.service';

describe('AchievementsService', () => {
  let service: AchievementsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AchievementsService,
        {
          provide: AchievementsService,
          useValue: {
            getAll: jest.fn().mockResolvedValue([]),
          },
        },
      ],
    }).compile();

    service = module.get<AchievementsService>(AchievementsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
