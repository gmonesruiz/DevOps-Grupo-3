import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { StoreController } from './store.controller';
import { StoreService } from './store.service';
import { StoreSchema } from './schema/store.schema';

@Module({
  imports: [MongooseModule.forFeature([{ name: 'Store', schema: StoreSchema }])],
  controllers: [StoreController],
  providers: [StoreService],
})
export class StoreModule {}
