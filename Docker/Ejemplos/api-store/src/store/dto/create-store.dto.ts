import { IsNotEmpty } from 'class-validator';
export class CreateStoreDto {
  @IsNotEmpty()
    readonly name: string;
    readonly description: string;
    readonly address: string;
    readonly phone: string;
    readonly products: Product[];
  }
  
  class Product {
    readonly name: string;
    readonly price: number;
    readonly description: string;
  }
  