import { Injectable, ConflictException, NotFoundException} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Store } from './interface/store.interface';
import { CreateStoreDto } from './dto/create-store.dto';
import { Product } from './schema/store.schema';

@Injectable()
export class StoreService {
  constructor(@InjectModel('Store') private readonly storeModel: Model<Store>) {}

  async create(createStoreDto: CreateStoreDto): Promise<Store> {
    const createdStore = new this.storeModel(createStoreDto);
    try { 
      return await createdStore.save();
    }catch (err) {
      if (err.code === 11000) {
        throw new ConflictException('Store already exists');
      }
    }
  }

  async findByName(name: string): Promise<Store> {
    return this.storeModel.findOne({ name }).exec();
  }
  
  async getId(name: string): Promise<string | null> {
    const store = await this.storeModel.findOne({ name }).exec();

    return store ? store._id.toString() : null;
  }

  async deleteStoreById(storeId: string): Promise<void> {
    const result = await this.storeModel.deleteOne({ _id: storeId }).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException(`Store with ID ${storeId} not found`);
    }
  }
  
  async getProducts(storeId: string): Promise<Product[]> {
    const store = await this.storeModel.findById(storeId).exec();

    if (!store) {
      throw new NotFoundException(`Store with ID ${storeId} not found`);
    }
    return store.products;
  }

  async findAll(): Promise<Store[]> {
    return this.storeModel.find().exec();
  }
}