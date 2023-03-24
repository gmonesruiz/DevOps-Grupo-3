import { Document } from 'mongoose';

export interface Store extends Document {
  readonly name: string;
  readonly description: string;
  readonly address: string;
  readonly phone: string;
  readonly products: Product[];
}

interface Product {
  readonly name: string;
  readonly price: number;
  readonly description: string;
}
