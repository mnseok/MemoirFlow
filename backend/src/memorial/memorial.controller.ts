import { Body, Controller, Headers, Post } from '@nestjs/common';
import { MemorialService } from './memorial.service';
import { CreateMemorialDto } from './dto/create.memorial.dto';
import { ApiOperation } from '@nestjs/swagger';

@Controller('memorial')
export class MemorialController {
  constructor(private readonly memorialService: MemorialService) {}

  @ApiOperation({ summary: 'Create a memorial' })
  @Post()
  postMemorial(
    @Headers('Authorization') token: string,
    @Body() data: CreateMemorialDto,
  ) {
    return this.memorialService.postMemorial(token, data);
  }
}
