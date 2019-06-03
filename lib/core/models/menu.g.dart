// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : Item.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'items': instance.items
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num)?.toDouble(),
      hasDrinks: json['hasDrinks'] as bool,
      hasAddOns: json['hasAddOns'] as bool);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'hasDrinks': instance.hasDrinks,
      'hasAddOns': instance.hasAddOns
    };
