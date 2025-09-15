// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductDto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDtoAdapter extends TypeAdapter<ProductDto> {
  @override
  final typeId = 0;

  @override
  ProductDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDto(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      (fields[4] as List).cast<Ingredient>(),
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.productTitle)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.productImage)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
