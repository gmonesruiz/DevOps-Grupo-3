import { Controller, Get, Post, Body, Delete, Param, NotFoundException} from '@nestjs/common';
import { StoreService } from './store.service';
import { CreateStoreDto } from './dto/create-store.dto';
import { Store } from './interface/store.interface';
import { Product } from './schema/store.schema';

@Controller('store')
export class StoreController {
  constructor(private readonly storeService: StoreService) {}

  @Post()
  async create(@Body() createStoreDto: CreateStoreDto): Promise<Store> {
    return this.storeService.create(createStoreDto);
  }

  @Get()
  async findAll(): Promise<Store[]> {
    return this.storeService.findAll();
  }

  @Get(':name/id')
  async getStoreId(@Param('name') storeName: string): Promise<string | null> {
    return this.storeService.getId(storeName);
  }
  @Delete(':id')
  async deleteStoreById(@Param('id') id: string): Promise<void> {
    return this.storeService.deleteStoreById(id);
  }
  @Get(':id/products')
  async getProducts(@Param('id') id: string): Promise<Product[]> {
    return this.storeService.getProducts(id);
  }
}