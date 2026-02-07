import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    console.log('Hello World 9!');

    const a = {
      a: 1,
      b: [
        {
          a: 1,
          c: 3,
        },
      ],
    };

    console.log({ a: JSON.stringify(a) });

    // I want to return json

    return JSON.stringify(a);
  }
}
