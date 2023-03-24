import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { StoreModule } from './store/store.module';
@Module({
  imports: [
    MongooseModule.forRoot('mongodb://root:root_password@localhost:27017/?authMechanism=DEFAULT'),
    StoreModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
