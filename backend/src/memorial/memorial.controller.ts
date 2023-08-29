import {
  Body,
  Controller,
  Get,
  Headers,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { MemorialService } from './memorial.service';
import { CreateMemorialDto } from './dto/create.memorial.dto';
import { ApiOperation } from '@nestjs/swagger';
import { CustomDate } from 'src/common/types/customDate.type';

@Controller('memorial')
export class MemorialController {
  constructor(private readonly memorialService: MemorialService) {}

  @ApiOperation({ summary: 'Create a memorial' })
  @Post()
  postMemorial(
    @Headers('Authorization') token: string,
    @Headers('Date') date: Date,
    @Body() data: CreateMemorialDto,
  ) {
    const dateObj: CustomDate = {
      year: date.getFullYear(),
      month: date.getMonth() + 1,
      day: date.getDate(),
    };

    return this.memorialService.postMemorial(token, data, dateObj);
  }

  @ApiOperation({ summary: 'Get memorials by user' })
  @Get()
  getMemorialsByUser(
    @Headers('Authorization') token: string,
    @Headers('Date') date: Date,
  ) {
    const dateObj: CustomDate = {
      year: date.getFullYear(),
      month: date.getMonth() + 1,
      day: date.getDate(),
    };
    return this.memorialService.getMemorialsByUser(token, dateObj);
  }

  @ApiOperation({ summary: 'Get memorials by user and memorial id' })
  @Get(':memorialId')
  getMemorialsByUserAndMemorialId(@Param('memorialId') memorialId: string) {
    return this.memorialService.getMemorialsByUserAndMemorialId(memorialId);
  }

  @ApiOperation({ summary: 'Update a memorial' })
  @Patch(':memorialId')
  updateMemorial(
    @Param('memorialId') memorialId: string,
    @Body() data: CreateMemorialDto,
  ) {
    return this.memorialService.updateMemorial(memorialId, data);
  }
}
