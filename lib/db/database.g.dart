// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES categories(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _salePriceMeta = const VerificationMeta(
    'salePrice',
  );
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
    'sale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<double> stock = GeneratedColumn<double>(
    'stock',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _trackStockMeta = const VerificationMeta(
    'trackStock',
  );
  @override
  late final GeneratedColumn<bool> trackStock = GeneratedColumn<bool>(
    'track_stock',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("track_stock" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _hasSubProductsMeta = const VerificationMeta(
    'hasSubProducts',
  );
  @override
  late final GeneratedColumn<bool> hasSubProducts = GeneratedColumn<bool>(
    'has_sub_products',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_sub_products" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AppActiveStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(AppActiveStatus.active.name),
      ).withConverter<AppActiveStatus>($ProductsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    description,
    salePrice,
    stock,
    trackStock,
    hasSubProducts,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sale_price')) {
      context.handle(
        _salePriceMeta,
        salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta),
      );
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('track_stock')) {
      context.handle(
        _trackStockMeta,
        trackStock.isAcceptableOrUnknown(data['track_stock']!, _trackStockMeta),
      );
    }
    if (data.containsKey('has_sub_products')) {
      context.handle(
        _hasSubProductsMeta,
        hasSubProducts.isAcceptableOrUnknown(
          data['has_sub_products']!,
          _hasSubProductsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      salePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sale_price'],
      )!,
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock'],
      )!,
      trackStock: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}track_stock'],
      )!,
      hasSubProducts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_sub_products'],
      )!,
      status: $ProductsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppActiveStatus, String, String> $converterstatus =
      const EnumNameConverter(AppActiveStatus.values);
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final double salePrice;
  final double stock;
  final bool trackStock;
  final bool hasSubProducts;
  final AppActiveStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.salePrice,
    required this.stock,
    required this.trackStock,
    required this.hasSubProducts,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sale_price'] = Variable<double>(salePrice);
    map['stock'] = Variable<double>(stock);
    map['track_stock'] = Variable<bool>(trackStock);
    map['has_sub_products'] = Variable<bool>(hasSubProducts);
    {
      map['status'] = Variable<String>(
        $ProductsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      salePrice: Value(salePrice),
      stock: Value(stock),
      trackStock: Value(trackStock),
      hasSubProducts: Value(hasSubProducts),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      stock: serializer.fromJson<double>(json['stock']),
      trackStock: serializer.fromJson<bool>(json['trackStock']),
      hasSubProducts: serializer.fromJson<bool>(json['hasSubProducts']),
      status: $ProductsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'salePrice': serializer.toJson<double>(salePrice),
      'stock': serializer.toJson<double>(stock),
      'trackStock': serializer.toJson<bool>(trackStock),
      'hasSubProducts': serializer.toJson<bool>(hasSubProducts),
      'status': serializer.toJson<String>(
        $ProductsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Product copyWith({
    int? id,
    int? categoryId,
    String? name,
    Value<String?> description = const Value.absent(),
    double? salePrice,
    double? stock,
    bool? trackStock,
    bool? hasSubProducts,
    AppActiveStatus? status,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    salePrice: salePrice ?? this.salePrice,
    stock: stock ?? this.stock,
    trackStock: trackStock ?? this.trackStock,
    hasSubProducts: hasSubProducts ?? this.hasSubProducts,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      stock: data.stock.present ? data.stock.value : this.stock,
      trackStock: data.trackStock.present
          ? data.trackStock.value
          : this.trackStock,
      hasSubProducts: data.hasSubProducts.present
          ? data.hasSubProducts.value
          : this.hasSubProducts,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('salePrice: $salePrice, ')
          ..write('stock: $stock, ')
          ..write('trackStock: $trackStock, ')
          ..write('hasSubProducts: $hasSubProducts, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    description,
    salePrice,
    stock,
    trackStock,
    hasSubProducts,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.salePrice == this.salePrice &&
          other.stock == this.stock &&
          other.trackStock == this.trackStock &&
          other.hasSubProducts == this.hasSubProducts &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> salePrice;
  final Value<double> stock;
  final Value<bool> trackStock;
  final Value<bool> hasSubProducts;
  final Value<AppActiveStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.trackStock = const Value.absent(),
    this.hasSubProducts = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    this.description = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.trackStock = const Value.absent(),
    this.hasSubProducts = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? salePrice,
    Expression<double>? stock,
    Expression<bool>? trackStock,
    Expression<bool>? hasSubProducts,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (salePrice != null) 'sale_price': salePrice,
      if (stock != null) 'stock': stock,
      if (trackStock != null) 'track_stock': trackStock,
      if (hasSubProducts != null) 'has_sub_products': hasSubProducts,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<String?>? description,
    Value<double>? salePrice,
    Value<double>? stock,
    Value<bool>? trackStock,
    Value<bool>? hasSubProducts,
    Value<AppActiveStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      trackStock: trackStock ?? this.trackStock,
      hasSubProducts: hasSubProducts ?? this.hasSubProducts,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (stock.present) {
      map['stock'] = Variable<double>(stock.value);
    }
    if (trackStock.present) {
      map['track_stock'] = Variable<bool>(trackStock.value);
    }
    if (hasSubProducts.present) {
      map['has_sub_products'] = Variable<bool>(hasSubProducts.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ProductsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('salePrice: $salePrice, ')
          ..write('stock: $stock, ')
          ..write('trackStock: $trackStock, ')
          ..write('hasSubProducts: $hasSubProducts, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CashRegistersTable extends CashRegisters
    with TableInfo<$CashRegistersTable, CashRegister> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashRegistersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _registerDateMeta = const VerificationMeta(
    'registerDate',
  );
  @override
  late final GeneratedColumn<DateTime> registerDate = GeneratedColumn<DateTime>(
    'register_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    $customConstraints: 'UNIQUE',
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _openingAmountMeta = const VerificationMeta(
    'openingAmount',
  );
  @override
  late final GeneratedColumn<double> openingAmount = GeneratedColumn<double>(
    'opening_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _closingAmountMeta = const VerificationMeta(
    'closingAmount',
  );
  @override
  late final GeneratedColumn<double> closingAmount = GeneratedColumn<double>(
    'closing_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalIncomeMeta = const VerificationMeta(
    'totalIncome',
  );
  @override
  late final GeneratedColumn<double> totalIncome = GeneratedColumn<double>(
    'total_sales',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalExpensesMeta = const VerificationMeta(
    'totalExpenses',
  );
  @override
  late final GeneratedColumn<double> totalExpenses = GeneratedColumn<double>(
    'total_expenses',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CashRegisterStatus, String>
  status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(CashRegisterStatus.open.name),
  ).withConverter<CashRegisterStatus>($CashRegistersTable.$converterstatus);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    registerDate,
    openingAmount,
    closingAmount,
    totalIncome,
    totalExpenses,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_registers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashRegister> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('register_date')) {
      context.handle(
        _registerDateMeta,
        registerDate.isAcceptableOrUnknown(
          data['register_date']!,
          _registerDateMeta,
        ),
      );
    }
    if (data.containsKey('opening_amount')) {
      context.handle(
        _openingAmountMeta,
        openingAmount.isAcceptableOrUnknown(
          data['opening_amount']!,
          _openingAmountMeta,
        ),
      );
    }
    if (data.containsKey('closing_amount')) {
      context.handle(
        _closingAmountMeta,
        closingAmount.isAcceptableOrUnknown(
          data['closing_amount']!,
          _closingAmountMeta,
        ),
      );
    }
    if (data.containsKey('total_sales')) {
      context.handle(
        _totalIncomeMeta,
        totalIncome.isAcceptableOrUnknown(
          data['total_sales']!,
          _totalIncomeMeta,
        ),
      );
    }
    if (data.containsKey('total_expenses')) {
      context.handle(
        _totalExpensesMeta,
        totalExpenses.isAcceptableOrUnknown(
          data['total_expenses']!,
          _totalExpensesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashRegister map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashRegister(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      registerDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}register_date'],
      )!,
      openingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}opening_amount'],
      )!,
      closingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}closing_amount'],
      ),
      totalIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_sales'],
      )!,
      totalExpenses: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_expenses'],
      )!,
      status: $CashRegistersTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $CashRegistersTable createAlias(String alias) {
    return $CashRegistersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CashRegisterStatus, String, String>
  $converterstatus = const EnumNameConverter(CashRegisterStatus.values);
}

class CashRegister extends DataClass implements Insertable<CashRegister> {
  final int id;
  final DateTime registerDate;
  final double openingAmount;
  final double? closingAmount;
  final double totalIncome;
  final double totalExpenses;
  final CashRegisterStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const CashRegister({
    required this.id,
    required this.registerDate,
    required this.openingAmount,
    this.closingAmount,
    required this.totalIncome,
    required this.totalExpenses,
    required this.status,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['register_date'] = Variable<DateTime>(registerDate);
    map['opening_amount'] = Variable<double>(openingAmount);
    if (!nullToAbsent || closingAmount != null) {
      map['closing_amount'] = Variable<double>(closingAmount);
    }
    map['total_sales'] = Variable<double>(totalIncome);
    map['total_expenses'] = Variable<double>(totalExpenses);
    {
      map['status'] = Variable<String>(
        $CashRegistersTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CashRegistersCompanion toCompanion(bool nullToAbsent) {
    return CashRegistersCompanion(
      id: Value(id),
      registerDate: Value(registerDate),
      openingAmount: Value(openingAmount),
      closingAmount: closingAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(closingAmount),
      totalIncome: Value(totalIncome),
      totalExpenses: Value(totalExpenses),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CashRegister.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashRegister(
      id: serializer.fromJson<int>(json['id']),
      registerDate: serializer.fromJson<DateTime>(json['registerDate']),
      openingAmount: serializer.fromJson<double>(json['openingAmount']),
      closingAmount: serializer.fromJson<double?>(json['closingAmount']),
      totalIncome: serializer.fromJson<double>(json['totalIncome']),
      totalExpenses: serializer.fromJson<double>(json['totalExpenses']),
      status: $CashRegistersTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'registerDate': serializer.toJson<DateTime>(registerDate),
      'openingAmount': serializer.toJson<double>(openingAmount),
      'closingAmount': serializer.toJson<double?>(closingAmount),
      'totalIncome': serializer.toJson<double>(totalIncome),
      'totalExpenses': serializer.toJson<double>(totalExpenses),
      'status': serializer.toJson<String>(
        $CashRegistersTable.$converterstatus.toJson(status),
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CashRegister copyWith({
    int? id,
    DateTime? registerDate,
    double? openingAmount,
    Value<double?> closingAmount = const Value.absent(),
    double? totalIncome,
    double? totalExpenses,
    CashRegisterStatus? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => CashRegister(
    id: id ?? this.id,
    registerDate: registerDate ?? this.registerDate,
    openingAmount: openingAmount ?? this.openingAmount,
    closingAmount: closingAmount.present
        ? closingAmount.value
        : this.closingAmount,
    totalIncome: totalIncome ?? this.totalIncome,
    totalExpenses: totalExpenses ?? this.totalExpenses,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CashRegister copyWithCompanion(CashRegistersCompanion data) {
    return CashRegister(
      id: data.id.present ? data.id.value : this.id,
      registerDate: data.registerDate.present
          ? data.registerDate.value
          : this.registerDate,
      openingAmount: data.openingAmount.present
          ? data.openingAmount.value
          : this.openingAmount,
      closingAmount: data.closingAmount.present
          ? data.closingAmount.value
          : this.closingAmount,
      totalIncome: data.totalIncome.present
          ? data.totalIncome.value
          : this.totalIncome,
      totalExpenses: data.totalExpenses.present
          ? data.totalExpenses.value
          : this.totalExpenses,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashRegister(')
          ..write('id: $id, ')
          ..write('registerDate: $registerDate, ')
          ..write('openingAmount: $openingAmount, ')
          ..write('closingAmount: $closingAmount, ')
          ..write('totalIncome: $totalIncome, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    registerDate,
    openingAmount,
    closingAmount,
    totalIncome,
    totalExpenses,
    status,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashRegister &&
          other.id == this.id &&
          other.registerDate == this.registerDate &&
          other.openingAmount == this.openingAmount &&
          other.closingAmount == this.closingAmount &&
          other.totalIncome == this.totalIncome &&
          other.totalExpenses == this.totalExpenses &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CashRegistersCompanion extends UpdateCompanion<CashRegister> {
  final Value<int> id;
  final Value<DateTime> registerDate;
  final Value<double> openingAmount;
  final Value<double?> closingAmount;
  final Value<double> totalIncome;
  final Value<double> totalExpenses;
  final Value<CashRegisterStatus> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const CashRegistersCompanion({
    this.id = const Value.absent(),
    this.registerDate = const Value.absent(),
    this.openingAmount = const Value.absent(),
    this.closingAmount = const Value.absent(),
    this.totalIncome = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CashRegistersCompanion.insert({
    this.id = const Value.absent(),
    this.registerDate = const Value.absent(),
    this.openingAmount = const Value.absent(),
    this.closingAmount = const Value.absent(),
    this.totalIncome = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<CashRegister> custom({
    Expression<int>? id,
    Expression<DateTime>? registerDate,
    Expression<double>? openingAmount,
    Expression<double>? closingAmount,
    Expression<double>? totalIncome,
    Expression<double>? totalExpenses,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (registerDate != null) 'register_date': registerDate,
      if (openingAmount != null) 'opening_amount': openingAmount,
      if (closingAmount != null) 'closing_amount': closingAmount,
      if (totalIncome != null) 'total_sales': totalIncome,
      if (totalExpenses != null) 'total_expenses': totalExpenses,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CashRegistersCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? registerDate,
    Value<double>? openingAmount,
    Value<double?>? closingAmount,
    Value<double>? totalIncome,
    Value<double>? totalExpenses,
    Value<CashRegisterStatus>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return CashRegistersCompanion(
      id: id ?? this.id,
      registerDate: registerDate ?? this.registerDate,
      openingAmount: openingAmount ?? this.openingAmount,
      closingAmount: closingAmount ?? this.closingAmount,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (registerDate.present) {
      map['register_date'] = Variable<DateTime>(registerDate.value);
    }
    if (openingAmount.present) {
      map['opening_amount'] = Variable<double>(openingAmount.value);
    }
    if (closingAmount.present) {
      map['closing_amount'] = Variable<double>(closingAmount.value);
    }
    if (totalIncome.present) {
      map['total_sales'] = Variable<double>(totalIncome.value);
    }
    if (totalExpenses.present) {
      map['total_expenses'] = Variable<double>(totalExpenses.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CashRegistersTable.$converterstatus.toSql(status.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashRegistersCompanion(')
          ..write('id: $id, ')
          ..write('registerDate: $registerDate, ')
          ..write('openingAmount: $openingAmount, ')
          ..write('closingAmount: $closingAmount, ')
          ..write('totalIncome: $totalIncome, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AppActiveStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(AppActiveStatus.active.name),
      ).withConverter<AppActiveStatus>($CategoriesTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      status: $CategoriesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppActiveStatus, String, String> $converterstatus =
      const EnumNameConverter(AppActiveStatus.values);
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String? description;
  final AppActiveStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Category({
    required this.id,
    required this.name,
    this.description,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['status'] = Variable<String>(
        $CategoriesTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      status: $CategoriesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(
        $CategoriesTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    AppActiveStatus? status,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<AppActiveStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<AppActiveStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CategoriesTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cashRegisterIdMeta = const VerificationMeta(
    'cashRegisterId',
  );
  @override
  late final GeneratedColumn<int> cashRegisterId = GeneratedColumn<int>(
    'cash_register_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES cash_registers(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RecordStatus.active.name),
      ).withConverter<RecordStatus>($ExpensesTable.$converterstatus);
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cashRegisterId,
    description,
    amount,
    status,
    expenseDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
        _cashRegisterIdMeta,
        cashRegisterId.isAcceptableOrUnknown(
          data['cash_register_id']!,
          _cashRegisterIdMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cashRegisterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cash_register_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      status: $ExpensesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expense_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordStatus, String, String> $converterstatus =
      const EnumNameConverter(RecordStatus.values);
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final int? cashRegisterId;
  final String description;
  final double amount;
  final RecordStatus status;
  final DateTime expenseDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Expense({
    required this.id,
    this.cashRegisterId,
    required this.description,
    required this.amount,
    required this.status,
    required this.expenseDate,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cashRegisterId != null) {
      map['cash_register_id'] = Variable<int>(cashRegisterId);
    }
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    {
      map['status'] = Variable<String>(
        $ExpensesTable.$converterstatus.toSql(status),
      );
    }
    map['expense_date'] = Variable<DateTime>(expenseDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      cashRegisterId: cashRegisterId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashRegisterId),
      description: Value(description),
      amount: Value(amount),
      status: Value(status),
      expenseDate: Value(expenseDate),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      cashRegisterId: serializer.fromJson<int?>(json['cashRegisterId']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      status: $ExpensesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cashRegisterId': serializer.toJson<int?>(cashRegisterId),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'status': serializer.toJson<String>(
        $ExpensesTable.$converterstatus.toJson(status),
      ),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Expense copyWith({
    int? id,
    Value<int?> cashRegisterId = const Value.absent(),
    String? description,
    double? amount,
    RecordStatus? status,
    DateTime? expenseDate,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    cashRegisterId: cashRegisterId.present
        ? cashRegisterId.value
        : this.cashRegisterId,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    expenseDate: expenseDate ?? this.expenseDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      status: data.status.present ? data.status.value : this.status,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cashRegisterId,
    description,
    amount,
    status,
    expenseDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.cashRegisterId == this.cashRegisterId &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.status == this.status &&
          other.expenseDate == this.expenseDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<int?> cashRegisterId;
  final Value<String> description;
  final Value<double> amount;
  final Value<RecordStatus> status;
  final Value<DateTime> expenseDate;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.status = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    required String description,
    this.amount = const Value.absent(),
    this.status = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : description = Value(description);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<int>? cashRegisterId,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? status,
    Expression<DateTime>? expenseDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (status != null) 'status': status,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<int?>? cashRegisterId,
    Value<String>? description,
    Value<double>? amount,
    Value<RecordStatus>? status,
    Value<DateTime>? expenseDate,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      expenseDate: expenseDate ?? this.expenseDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<int>(cashRegisterId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ExpensesTable.$converterstatus.toSql(status.value),
      );
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _cashRegisterIdMeta = const VerificationMeta(
    'cashRegisterId',
  );
  @override
  late final GeneratedColumn<int> cashRegisterId = GeneratedColumn<int>(
    'cash_register_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES cash_registers(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<int> paymentMethodId = GeneratedColumn<int>(
    'payment_method_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES payment_methods(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _aliasProductNameMeta = const VerificationMeta(
    'aliasProductName',
  );
  @override
  late final GeneratedColumn<String> aliasProductName = GeneratedColumn<String>(
    'alias_product_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSoldOutMeta = const VerificationMeta(
    'isSoldOut',
  );
  @override
  late final GeneratedColumn<bool> isSoldOut = GeneratedColumn<bool>(
    'is_sold_out',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sold_out" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RecordStatus.active.name),
      ).withConverter<RecordStatus>($PurchasesTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    cashRegisterId,
    paymentMethodId,
    aliasProductName,
    quantity,
    totalCost,
    purchaseDate,
    notes,
    isSoldOut,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Purchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
        _cashRegisterIdMeta,
        cashRegisterId.isAcceptableOrUnknown(
          data['cash_register_id']!,
          _cashRegisterIdMeta,
        ),
      );
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodIdMeta);
    }
    if (data.containsKey('alias_product_name')) {
      context.handle(
        _aliasProductNameMeta,
        aliasProductName.isAcceptableOrUnknown(
          data['alias_product_name']!,
          _aliasProductNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aliasProductNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_sold_out')) {
      context.handle(
        _isSoldOutMeta,
        isSoldOut.isAcceptableOrUnknown(data['is_sold_out']!, _isSoldOutMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      cashRegisterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cash_register_id'],
      ),
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_method_id'],
      )!,
      aliasProductName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias_product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isSoldOut: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sold_out'],
      )!,
      status: $PurchasesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordStatus, String, String> $converterstatus =
      const EnumNameConverter(RecordStatus.values);
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final int id;
  final int productId;
  final int? cashRegisterId;
  final int paymentMethodId;
  final String aliasProductName;
  final double quantity;
  final double totalCost;
  final DateTime purchaseDate;
  final String? notes;
  final bool isSoldOut;
  final RecordStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Purchase({
    required this.id,
    required this.productId,
    this.cashRegisterId,
    required this.paymentMethodId,
    required this.aliasProductName,
    required this.quantity,
    required this.totalCost,
    required this.purchaseDate,
    this.notes,
    required this.isSoldOut,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || cashRegisterId != null) {
      map['cash_register_id'] = Variable<int>(cashRegisterId);
    }
    map['payment_method_id'] = Variable<int>(paymentMethodId);
    map['alias_product_name'] = Variable<String>(aliasProductName);
    map['quantity'] = Variable<double>(quantity);
    map['total_cost'] = Variable<double>(totalCost);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_sold_out'] = Variable<bool>(isSoldOut);
    {
      map['status'] = Variable<String>(
        $PurchasesTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      productId: Value(productId),
      cashRegisterId: cashRegisterId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashRegisterId),
      paymentMethodId: Value(paymentMethodId),
      aliasProductName: Value(aliasProductName),
      quantity: Value(quantity),
      totalCost: Value(totalCost),
      purchaseDate: Value(purchaseDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isSoldOut: Value(isSoldOut),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Purchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      cashRegisterId: serializer.fromJson<int?>(json['cashRegisterId']),
      paymentMethodId: serializer.fromJson<int>(json['paymentMethodId']),
      aliasProductName: serializer.fromJson<String>(json['aliasProductName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      isSoldOut: serializer.fromJson<bool>(json['isSoldOut']),
      status: $PurchasesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'cashRegisterId': serializer.toJson<int?>(cashRegisterId),
      'paymentMethodId': serializer.toJson<int>(paymentMethodId),
      'aliasProductName': serializer.toJson<String>(aliasProductName),
      'quantity': serializer.toJson<double>(quantity),
      'totalCost': serializer.toJson<double>(totalCost),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'notes': serializer.toJson<String?>(notes),
      'isSoldOut': serializer.toJson<bool>(isSoldOut),
      'status': serializer.toJson<String>(
        $PurchasesTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Purchase copyWith({
    int? id,
    int? productId,
    Value<int?> cashRegisterId = const Value.absent(),
    int? paymentMethodId,
    String? aliasProductName,
    double? quantity,
    double? totalCost,
    DateTime? purchaseDate,
    Value<String?> notes = const Value.absent(),
    bool? isSoldOut,
    RecordStatus? status,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Purchase(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    cashRegisterId: cashRegisterId.present
        ? cashRegisterId.value
        : this.cashRegisterId,
    paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    aliasProductName: aliasProductName ?? this.aliasProductName,
    quantity: quantity ?? this.quantity,
    totalCost: totalCost ?? this.totalCost,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    notes: notes.present ? notes.value : this.notes,
    isSoldOut: isSoldOut ?? this.isSoldOut,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      aliasProductName: data.aliasProductName.present
          ? data.aliasProductName.value
          : this.aliasProductName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      isSoldOut: data.isSoldOut.present ? data.isSoldOut.value : this.isSoldOut,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('aliasProductName: $aliasProductName, ')
          ..write('quantity: $quantity, ')
          ..write('totalCost: $totalCost, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('notes: $notes, ')
          ..write('isSoldOut: $isSoldOut, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    cashRegisterId,
    paymentMethodId,
    aliasProductName,
    quantity,
    totalCost,
    purchaseDate,
    notes,
    isSoldOut,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.cashRegisterId == this.cashRegisterId &&
          other.paymentMethodId == this.paymentMethodId &&
          other.aliasProductName == this.aliasProductName &&
          other.quantity == this.quantity &&
          other.totalCost == this.totalCost &&
          other.purchaseDate == this.purchaseDate &&
          other.notes == this.notes &&
          other.isSoldOut == this.isSoldOut &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int?> cashRegisterId;
  final Value<int> paymentMethodId;
  final Value<String> aliasProductName;
  final Value<double> quantity;
  final Value<double> totalCost;
  final Value<DateTime> purchaseDate;
  final Value<String?> notes;
  final Value<bool> isSoldOut;
  final Value<RecordStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.aliasProductName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isSoldOut = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.cashRegisterId = const Value.absent(),
    required int paymentMethodId,
    required String aliasProductName,
    this.quantity = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isSoldOut = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : productId = Value(productId),
       paymentMethodId = Value(paymentMethodId),
       aliasProductName = Value(aliasProductName);
  static Insertable<Purchase> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? cashRegisterId,
    Expression<int>? paymentMethodId,
    Expression<String>? aliasProductName,
    Expression<double>? quantity,
    Expression<double>? totalCost,
    Expression<DateTime>? purchaseDate,
    Expression<String>? notes,
    Expression<bool>? isSoldOut,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (aliasProductName != null) 'alias_product_name': aliasProductName,
      if (quantity != null) 'quantity': quantity,
      if (totalCost != null) 'total_cost': totalCost,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (notes != null) 'notes': notes,
      if (isSoldOut != null) 'is_sold_out': isSoldOut,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PurchasesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int?>? cashRegisterId,
    Value<int>? paymentMethodId,
    Value<String>? aliasProductName,
    Value<double>? quantity,
    Value<double>? totalCost,
    Value<DateTime>? purchaseDate,
    Value<String?>? notes,
    Value<bool>? isSoldOut,
    Value<RecordStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      aliasProductName: aliasProductName ?? this.aliasProductName,
      quantity: quantity ?? this.quantity,
      totalCost: totalCost ?? this.totalCost,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      notes: notes ?? this.notes,
      isSoldOut: isSoldOut ?? this.isSoldOut,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<int>(cashRegisterId.value);
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<int>(paymentMethodId.value);
    }
    if (aliasProductName.present) {
      map['alias_product_name'] = Variable<String>(aliasProductName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isSoldOut.present) {
      map['is_sold_out'] = Variable<bool>(isSoldOut.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PurchasesTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('aliasProductName: $aliasProductName, ')
          ..write('quantity: $quantity, ')
          ..write('totalCost: $totalCost, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('notes: $notes, ')
          ..write('isSoldOut: $isSoldOut, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES purchases(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _cashRegisterIdMeta = const VerificationMeta(
    'cashRegisterId',
  );
  @override
  late final GeneratedColumn<int> cashRegisterId = GeneratedColumn<int>(
    'cash_register_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES cash_registers(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _paymentMethodIdMeta = const VerificationMeta(
    'paymentMethodId',
  );
  @override
  late final GeneratedColumn<int> paymentMethodId = GeneratedColumn<int>(
    'payment_method_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES payment_methods(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _aliasProductNameMeta = const VerificationMeta(
    'aliasProductName',
  );
  @override
  late final GeneratedColumn<String> aliasProductName = GeneratedColumn<String>(
    'alias_product_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RecordStatus.active.name),
      ).withConverter<RecordStatus>($SalesTable.$converterstatus);
  static const VerificationMeta _saleDateMeta = const VerificationMeta(
    'saleDate',
  );
  @override
  late final GeneratedColumn<DateTime> saleDate = GeneratedColumn<DateTime>(
    'sale_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    purchaseId,
    cashRegisterId,
    paymentMethodId,
    aliasProductName,
    quantity,
    totalPrice,
    notes,
    status,
    saleDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
        _cashRegisterIdMeta,
        cashRegisterId.isAcceptableOrUnknown(
          data['cash_register_id']!,
          _cashRegisterIdMeta,
        ),
      );
    }
    if (data.containsKey('payment_method_id')) {
      context.handle(
        _paymentMethodIdMeta,
        paymentMethodId.isAcceptableOrUnknown(
          data['payment_method_id']!,
          _paymentMethodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodIdMeta);
    }
    if (data.containsKey('alias_product_name')) {
      context.handle(
        _aliasProductNameMeta,
        aliasProductName.isAcceptableOrUnknown(
          data['alias_product_name']!,
          _aliasProductNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aliasProductNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sale_date')) {
      context.handle(
        _saleDateMeta,
        saleDate.isAcceptableOrUnknown(data['sale_date']!, _saleDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      ),
      cashRegisterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cash_register_id'],
      ),
      paymentMethodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_method_id'],
      )!,
      aliasProductName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias_product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: $SalesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      saleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sale_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordStatus, String, String> $converterstatus =
      const EnumNameConverter(RecordStatus.values);
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final int productId;
  final int? purchaseId;
  final int? cashRegisterId;
  final int paymentMethodId;
  final String aliasProductName;
  final double quantity;
  final double totalPrice;
  final String? notes;
  final RecordStatus status;
  final DateTime saleDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Sale({
    required this.id,
    required this.productId,
    this.purchaseId,
    this.cashRegisterId,
    required this.paymentMethodId,
    required this.aliasProductName,
    required this.quantity,
    required this.totalPrice,
    this.notes,
    required this.status,
    required this.saleDate,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<int>(purchaseId);
    }
    if (!nullToAbsent || cashRegisterId != null) {
      map['cash_register_id'] = Variable<int>(cashRegisterId);
    }
    map['payment_method_id'] = Variable<int>(paymentMethodId);
    map['alias_product_name'] = Variable<String>(aliasProductName);
    map['quantity'] = Variable<double>(quantity);
    map['total_price'] = Variable<double>(totalPrice);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['status'] = Variable<String>(
        $SalesTable.$converterstatus.toSql(status),
      );
    }
    map['sale_date'] = Variable<DateTime>(saleDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      productId: Value(productId),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      cashRegisterId: cashRegisterId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashRegisterId),
      paymentMethodId: Value(paymentMethodId),
      aliasProductName: Value(aliasProductName),
      quantity: Value(quantity),
      totalPrice: Value(totalPrice),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      saleDate: Value(saleDate),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      purchaseId: serializer.fromJson<int?>(json['purchaseId']),
      cashRegisterId: serializer.fromJson<int?>(json['cashRegisterId']),
      paymentMethodId: serializer.fromJson<int>(json['paymentMethodId']),
      aliasProductName: serializer.fromJson<String>(json['aliasProductName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: $SalesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      saleDate: serializer.fromJson<DateTime>(json['saleDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'purchaseId': serializer.toJson<int?>(purchaseId),
      'cashRegisterId': serializer.toJson<int?>(cashRegisterId),
      'paymentMethodId': serializer.toJson<int>(paymentMethodId),
      'aliasProductName': serializer.toJson<String>(aliasProductName),
      'quantity': serializer.toJson<double>(quantity),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(
        $SalesTable.$converterstatus.toJson(status),
      ),
      'saleDate': serializer.toJson<DateTime>(saleDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Sale copyWith({
    int? id,
    int? productId,
    Value<int?> purchaseId = const Value.absent(),
    Value<int?> cashRegisterId = const Value.absent(),
    int? paymentMethodId,
    String? aliasProductName,
    double? quantity,
    double? totalPrice,
    Value<String?> notes = const Value.absent(),
    RecordStatus? status,
    DateTime? saleDate,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Sale(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    cashRegisterId: cashRegisterId.present
        ? cashRegisterId.value
        : this.cashRegisterId,
    paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    aliasProductName: aliasProductName ?? this.aliasProductName,
    quantity: quantity ?? this.quantity,
    totalPrice: totalPrice ?? this.totalPrice,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    saleDate: saleDate ?? this.saleDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      paymentMethodId: data.paymentMethodId.present
          ? data.paymentMethodId.value
          : this.paymentMethodId,
      aliasProductName: data.aliasProductName.present
          ? data.aliasProductName.value
          : this.aliasProductName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      saleDate: data.saleDate.present ? data.saleDate.value : this.saleDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('aliasProductName: $aliasProductName, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('saleDate: $saleDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    purchaseId,
    cashRegisterId,
    paymentMethodId,
    aliasProductName,
    quantity,
    totalPrice,
    notes,
    status,
    saleDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.purchaseId == this.purchaseId &&
          other.cashRegisterId == this.cashRegisterId &&
          other.paymentMethodId == this.paymentMethodId &&
          other.aliasProductName == this.aliasProductName &&
          other.quantity == this.quantity &&
          other.totalPrice == this.totalPrice &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.saleDate == this.saleDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int?> purchaseId;
  final Value<int?> cashRegisterId;
  final Value<int> paymentMethodId;
  final Value<String> aliasProductName;
  final Value<double> quantity;
  final Value<double> totalPrice;
  final Value<String?> notes;
  final Value<RecordStatus> status;
  final Value<DateTime> saleDate;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.paymentMethodId = const Value.absent(),
    this.aliasProductName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.saleDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.purchaseId = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    required int paymentMethodId,
    required String aliasProductName,
    this.quantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.saleDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : productId = Value(productId),
       paymentMethodId = Value(paymentMethodId),
       aliasProductName = Value(aliasProductName);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? purchaseId,
    Expression<int>? cashRegisterId,
    Expression<int>? paymentMethodId,
    Expression<String>? aliasProductName,
    Expression<double>? quantity,
    Expression<double>? totalPrice,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? saleDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (paymentMethodId != null) 'payment_method_id': paymentMethodId,
      if (aliasProductName != null) 'alias_product_name': aliasProductName,
      if (quantity != null) 'quantity': quantity,
      if (totalPrice != null) 'total_price': totalPrice,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (saleDate != null) 'sale_date': saleDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int?>? purchaseId,
    Value<int?>? cashRegisterId,
    Value<int>? paymentMethodId,
    Value<String>? aliasProductName,
    Value<double>? quantity,
    Value<double>? totalPrice,
    Value<String?>? notes,
    Value<RecordStatus>? status,
    Value<DateTime>? saleDate,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      purchaseId: purchaseId ?? this.purchaseId,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      aliasProductName: aliasProductName ?? this.aliasProductName,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      saleDate: saleDate ?? this.saleDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<int>(cashRegisterId.value);
    }
    if (paymentMethodId.present) {
      map['payment_method_id'] = Variable<int>(paymentMethodId.value);
    }
    if (aliasProductName.present) {
      map['alias_product_name'] = Variable<String>(aliasProductName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SalesTable.$converterstatus.toSql(status.value),
      );
    }
    if (saleDate.present) {
      map['sale_date'] = Variable<DateTime>(saleDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('paymentMethodId: $paymentMethodId, ')
          ..write('aliasProductName: $aliasProductName, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('saleDate: $saleDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentMethodsTable extends PaymentMethods
    with TableInfo<$PaymentMethodsTable, PaymentMethod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AppActiveStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(AppActiveStatus.active.name),
      ).withConverter<AppActiveStatus>($PaymentMethodsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    displayOrder,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentMethod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentMethod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentMethod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      status: $PaymentMethodsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $PaymentMethodsTable createAlias(String alias) {
    return $PaymentMethodsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppActiveStatus, String, String> $converterstatus =
      const EnumNameConverter(AppActiveStatus.values);
}

class PaymentMethod extends DataClass implements Insertable<PaymentMethod> {
  final int id;
  final String name;
  final String? description;
  final int displayOrder;
  final AppActiveStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const PaymentMethod({
    required this.id,
    required this.name,
    this.description,
    required this.displayOrder,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['display_order'] = Variable<int>(displayOrder);
    {
      map['status'] = Variable<String>(
        $PaymentMethodsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PaymentMethodsCompanion toCompanion(bool nullToAbsent) {
    return PaymentMethodsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      displayOrder: Value(displayOrder),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PaymentMethod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentMethod(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      status: $PaymentMethodsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'status': serializer.toJson<String>(
        $PaymentMethodsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  PaymentMethod copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    int? displayOrder,
    AppActiveStatus? status,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => PaymentMethod(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    displayOrder: displayOrder ?? this.displayOrder,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  PaymentMethod copyWithCompanion(PaymentMethodsCompanion data) {
    return PaymentMethod(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethod(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    displayOrder,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentMethod &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.displayOrder == this.displayOrder &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentMethodsCompanion extends UpdateCompanion<PaymentMethod> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> displayOrder;
  final Value<AppActiveStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const PaymentMethodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PaymentMethodsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PaymentMethod> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? displayOrder,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (displayOrder != null) 'display_order': displayOrder,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PaymentMethodsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? displayOrder,
    Value<AppActiveStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return PaymentMethodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      displayOrder: displayOrder ?? this.displayOrder,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PaymentMethodsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentMethodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IncomesTable extends Incomes with TableInfo<$IncomesTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cashRegisterIdMeta = const VerificationMeta(
    'cashRegisterId',
  );
  @override
  late final GeneratedColumn<int> cashRegisterId = GeneratedColumn<int>(
    'cash_register_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES cash_registers(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RecordStatus.active.name),
      ).withConverter<RecordStatus>($IncomesTable.$converterstatus);
  static const VerificationMeta _incomeDateMeta = const VerificationMeta(
    'incomeDate',
  );
  @override
  late final GeneratedColumn<DateTime> incomeDate = GeneratedColumn<DateTime>(
    'income_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cashRegisterId,
    amount,
    description,
    status,
    incomeDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Income> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
        _cashRegisterIdMeta,
        cashRegisterId.isAcceptableOrUnknown(
          data['cash_register_id']!,
          _cashRegisterIdMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('income_date')) {
      context.handle(
        _incomeDateMeta,
        incomeDate.isAcceptableOrUnknown(data['income_date']!, _incomeDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Income(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cashRegisterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cash_register_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      status: $IncomesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      incomeDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}income_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $IncomesTable createAlias(String alias) {
    return $IncomesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordStatus, String, String> $converterstatus =
      const EnumNameConverter(RecordStatus.values);
}

class Income extends DataClass implements Insertable<Income> {
  final int id;
  final int? cashRegisterId;
  final double amount;
  final String description;
  final RecordStatus status;
  final DateTime incomeDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Income({
    required this.id,
    this.cashRegisterId,
    required this.amount,
    required this.description,
    required this.status,
    required this.incomeDate,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cashRegisterId != null) {
      map['cash_register_id'] = Variable<int>(cashRegisterId);
    }
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    {
      map['status'] = Variable<String>(
        $IncomesTable.$converterstatus.toSql(status),
      );
    }
    map['income_date'] = Variable<DateTime>(incomeDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  IncomesCompanion toCompanion(bool nullToAbsent) {
    return IncomesCompanion(
      id: Value(id),
      cashRegisterId: cashRegisterId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashRegisterId),
      amount: Value(amount),
      description: Value(description),
      status: Value(status),
      incomeDate: Value(incomeDate),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Income.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Income(
      id: serializer.fromJson<int>(json['id']),
      cashRegisterId: serializer.fromJson<int?>(json['cashRegisterId']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      status: $IncomesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      incomeDate: serializer.fromJson<DateTime>(json['incomeDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cashRegisterId': serializer.toJson<int?>(cashRegisterId),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'status': serializer.toJson<String>(
        $IncomesTable.$converterstatus.toJson(status),
      ),
      'incomeDate': serializer.toJson<DateTime>(incomeDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Income copyWith({
    int? id,
    Value<int?> cashRegisterId = const Value.absent(),
    double? amount,
    String? description,
    RecordStatus? status,
    DateTime? incomeDate,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Income(
    id: id ?? this.id,
    cashRegisterId: cashRegisterId.present
        ? cashRegisterId.value
        : this.cashRegisterId,
    amount: amount ?? this.amount,
    description: description ?? this.description,
    status: status ?? this.status,
    incomeDate: incomeDate ?? this.incomeDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Income copyWithCompanion(IncomesCompanion data) {
    return Income(
      id: data.id.present ? data.id.value : this.id,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      amount: data.amount.present ? data.amount.value : this.amount,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
      incomeDate: data.incomeDate.present
          ? data.incomeDate.value
          : this.incomeDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Income(')
          ..write('id: $id, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('incomeDate: $incomeDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cashRegisterId,
    amount,
    description,
    status,
    incomeDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Income &&
          other.id == this.id &&
          other.cashRegisterId == this.cashRegisterId &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.status == this.status &&
          other.incomeDate == this.incomeDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IncomesCompanion extends UpdateCompanion<Income> {
  final Value<int> id;
  final Value<int?> cashRegisterId;
  final Value<double> amount;
  final Value<String> description;
  final Value<RecordStatus> status;
  final Value<DateTime> incomeDate;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const IncomesCompanion({
    this.id = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.incomeDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  IncomesCompanion.insert({
    this.id = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    required double amount,
    required String description,
    this.status = const Value.absent(),
    this.incomeDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : amount = Value(amount),
       description = Value(description);
  static Insertable<Income> custom({
    Expression<int>? id,
    Expression<int>? cashRegisterId,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<String>? status,
    Expression<DateTime>? incomeDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (incomeDate != null) 'income_date': incomeDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  IncomesCompanion copyWith({
    Value<int>? id,
    Value<int?>? cashRegisterId,
    Value<double>? amount,
    Value<String>? description,
    Value<RecordStatus>? status,
    Value<DateTime>? incomeDate,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return IncomesCompanion(
      id: id ?? this.id,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      status: status ?? this.status,
      incomeDate: incomeDate ?? this.incomeDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<int>(cashRegisterId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $IncomesTable.$converterstatus.toSql(status.value),
      );
    }
    if (incomeDate.present) {
      map['income_date'] = Variable<DateTime>(incomeDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCompanion(')
          ..write('id: $id, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('incomeDate: $incomeDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductSubproductsTable extends ProductSubproducts
    with TableInfo<$ProductSubproductsTable, ProductSubproduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductSubproductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _subproductIdMeta = const VerificationMeta(
    'subproductId',
  );
  @override
  late final GeneratedColumn<int> subproductId = GeneratedColumn<int>(
    'subproduct_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES products(id) ON DELETE CASCADE',
  );
  @override
  List<GeneratedColumn> get $columns => [productId, subproductId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_subproducts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductSubproduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('subproduct_id')) {
      context.handle(
        _subproductIdMeta,
        subproductId.isAcceptableOrUnknown(
          data['subproduct_id']!,
          _subproductIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subproductIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, subproductId};
  @override
  ProductSubproduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductSubproduct(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      subproductId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subproduct_id'],
      )!,
    );
  }

  @override
  $ProductSubproductsTable createAlias(String alias) {
    return $ProductSubproductsTable(attachedDatabase, alias);
  }
}

class ProductSubproduct extends DataClass
    implements Insertable<ProductSubproduct> {
  final int productId;
  final int subproductId;
  const ProductSubproduct({
    required this.productId,
    required this.subproductId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['subproduct_id'] = Variable<int>(subproductId);
    return map;
  }

  ProductSubproductsCompanion toCompanion(bool nullToAbsent) {
    return ProductSubproductsCompanion(
      productId: Value(productId),
      subproductId: Value(subproductId),
    );
  }

  factory ProductSubproduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductSubproduct(
      productId: serializer.fromJson<int>(json['productId']),
      subproductId: serializer.fromJson<int>(json['subproductId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'subproductId': serializer.toJson<int>(subproductId),
    };
  }

  ProductSubproduct copyWith({int? productId, int? subproductId}) =>
      ProductSubproduct(
        productId: productId ?? this.productId,
        subproductId: subproductId ?? this.subproductId,
      );
  ProductSubproduct copyWithCompanion(ProductSubproductsCompanion data) {
    return ProductSubproduct(
      productId: data.productId.present ? data.productId.value : this.productId,
      subproductId: data.subproductId.present
          ? data.subproductId.value
          : this.subproductId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductSubproduct(')
          ..write('productId: $productId, ')
          ..write('subproductId: $subproductId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, subproductId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductSubproduct &&
          other.productId == this.productId &&
          other.subproductId == this.subproductId);
}

class ProductSubproductsCompanion extends UpdateCompanion<ProductSubproduct> {
  final Value<int> productId;
  final Value<int> subproductId;
  final Value<int> rowid;
  const ProductSubproductsCompanion({
    this.productId = const Value.absent(),
    this.subproductId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductSubproductsCompanion.insert({
    required int productId,
    required int subproductId,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       subproductId = Value(subproductId);
  static Insertable<ProductSubproduct> custom({
    Expression<int>? productId,
    Expression<int>? subproductId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (subproductId != null) 'subproduct_id': subproductId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductSubproductsCompanion copyWith({
    Value<int>? productId,
    Value<int>? subproductId,
    Value<int>? rowid,
  }) {
    return ProductSubproductsCompanion(
      productId: productId ?? this.productId,
      subproductId: subproductId ?? this.subproductId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (subproductId.present) {
      map['subproduct_id'] = Variable<int>(subproductId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductSubproductsCompanion(')
          ..write('productId: $productId, ')
          ..write('subproductId: $subproductId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryLossesTable extends InventoryLosses
    with TableInfo<$InventoryLossesTable, InventoryLossesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryLossesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _cashRegisterIdMeta = const VerificationMeta(
    'cashRegisterId',
  );
  @override
  late final GeneratedColumn<int> cashRegisterId = GeneratedColumn<int>(
    'cash_register_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES cash_registers(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _lossTypeIdMeta = const VerificationMeta(
    'lossTypeId',
  );
  @override
  late final GeneratedColumn<int> lossTypeId = GeneratedColumn<int>(
    'loss_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES loss_types(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecordStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 50,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RecordStatus.active.name),
      ).withConverter<RecordStatus>($InventoryLossesTable.$converterstatus);
  static const VerificationMeta _lossDateMeta = const VerificationMeta(
    'lossDate',
  );
  @override
  late final GeneratedColumn<DateTime> lossDate = GeneratedColumn<DateTime>(
    'loss_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    cashRegisterId,
    lossTypeId,
    quantity,
    description,
    status,
    lossDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_losses';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryLossesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
        _cashRegisterIdMeta,
        cashRegisterId.isAcceptableOrUnknown(
          data['cash_register_id']!,
          _cashRegisterIdMeta,
        ),
      );
    }
    if (data.containsKey('loss_type_id')) {
      context.handle(
        _lossTypeIdMeta,
        lossTypeId.isAcceptableOrUnknown(
          data['loss_type_id']!,
          _lossTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lossTypeIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('loss_date')) {
      context.handle(
        _lossDateMeta,
        lossDate.isAcceptableOrUnknown(data['loss_date']!, _lossDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryLossesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryLossesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      cashRegisterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cash_register_id'],
      ),
      lossTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loss_type_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      status: $InventoryLossesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      lossDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}loss_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $InventoryLossesTable createAlias(String alias) {
    return $InventoryLossesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordStatus, String, String> $converterstatus =
      const EnumNameConverter(RecordStatus.values);
}

class InventoryLossesData extends DataClass
    implements Insertable<InventoryLossesData> {
  final int id;
  final int productId;
  final int? cashRegisterId;
  final int lossTypeId;
  final double quantity;
  final String? description;
  final RecordStatus status;
  final DateTime lossDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const InventoryLossesData({
    required this.id,
    required this.productId,
    this.cashRegisterId,
    required this.lossTypeId,
    required this.quantity,
    this.description,
    required this.status,
    required this.lossDate,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || cashRegisterId != null) {
      map['cash_register_id'] = Variable<int>(cashRegisterId);
    }
    map['loss_type_id'] = Variable<int>(lossTypeId);
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['status'] = Variable<String>(
        $InventoryLossesTable.$converterstatus.toSql(status),
      );
    }
    map['loss_date'] = Variable<DateTime>(lossDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  InventoryLossesCompanion toCompanion(bool nullToAbsent) {
    return InventoryLossesCompanion(
      id: Value(id),
      productId: Value(productId),
      cashRegisterId: cashRegisterId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashRegisterId),
      lossTypeId: Value(lossTypeId),
      quantity: Value(quantity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      lossDate: Value(lossDate),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory InventoryLossesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryLossesData(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      cashRegisterId: serializer.fromJson<int?>(json['cashRegisterId']),
      lossTypeId: serializer.fromJson<int>(json['lossTypeId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      description: serializer.fromJson<String?>(json['description']),
      status: $InventoryLossesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      lossDate: serializer.fromJson<DateTime>(json['lossDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'cashRegisterId': serializer.toJson<int?>(cashRegisterId),
      'lossTypeId': serializer.toJson<int>(lossTypeId),
      'quantity': serializer.toJson<double>(quantity),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(
        $InventoryLossesTable.$converterstatus.toJson(status),
      ),
      'lossDate': serializer.toJson<DateTime>(lossDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  InventoryLossesData copyWith({
    int? id,
    int? productId,
    Value<int?> cashRegisterId = const Value.absent(),
    int? lossTypeId,
    double? quantity,
    Value<String?> description = const Value.absent(),
    RecordStatus? status,
    DateTime? lossDate,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => InventoryLossesData(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    cashRegisterId: cashRegisterId.present
        ? cashRegisterId.value
        : this.cashRegisterId,
    lossTypeId: lossTypeId ?? this.lossTypeId,
    quantity: quantity ?? this.quantity,
    description: description.present ? description.value : this.description,
    status: status ?? this.status,
    lossDate: lossDate ?? this.lossDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  InventoryLossesData copyWithCompanion(InventoryLossesCompanion data) {
    return InventoryLossesData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      lossTypeId: data.lossTypeId.present
          ? data.lossTypeId.value
          : this.lossTypeId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
      lossDate: data.lossDate.present ? data.lossDate.value : this.lossDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLossesData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('lossTypeId: $lossTypeId, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('lossDate: $lossDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    cashRegisterId,
    lossTypeId,
    quantity,
    description,
    status,
    lossDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryLossesData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.cashRegisterId == this.cashRegisterId &&
          other.lossTypeId == this.lossTypeId &&
          other.quantity == this.quantity &&
          other.description == this.description &&
          other.status == this.status &&
          other.lossDate == this.lossDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InventoryLossesCompanion extends UpdateCompanion<InventoryLossesData> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int?> cashRegisterId;
  final Value<int> lossTypeId;
  final Value<double> quantity;
  final Value<String?> description;
  final Value<RecordStatus> status;
  final Value<DateTime> lossDate;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const InventoryLossesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.lossTypeId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.lossDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InventoryLossesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.cashRegisterId = const Value.absent(),
    required int lossTypeId,
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.lossDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : productId = Value(productId),
       lossTypeId = Value(lossTypeId);
  static Insertable<InventoryLossesData> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? cashRegisterId,
    Expression<int>? lossTypeId,
    Expression<double>? quantity,
    Expression<String>? description,
    Expression<String>? status,
    Expression<DateTime>? lossDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (lossTypeId != null) 'loss_type_id': lossTypeId,
      if (quantity != null) 'quantity': quantity,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (lossDate != null) 'loss_date': lossDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InventoryLossesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int?>? cashRegisterId,
    Value<int>? lossTypeId,
    Value<double>? quantity,
    Value<String?>? description,
    Value<RecordStatus>? status,
    Value<DateTime>? lossDate,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return InventoryLossesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      lossTypeId: lossTypeId ?? this.lossTypeId,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      status: status ?? this.status,
      lossDate: lossDate ?? this.lossDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<int>(cashRegisterId.value);
    }
    if (lossTypeId.present) {
      map['loss_type_id'] = Variable<int>(lossTypeId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InventoryLossesTable.$converterstatus.toSql(status.value),
      );
    }
    if (lossDate.present) {
      map['loss_date'] = Variable<DateTime>(lossDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLossesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('lossTypeId: $lossTypeId, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('lossDate: $lossDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LossTypesTable extends LossTypes
    with TableInfo<$LossTypesTable, LossType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LossTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE',
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loss_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<LossType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LossType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LossType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LossTypesTable createAlias(String alias) {
    return $LossTypesTable(attachedDatabase, alias);
  }
}

class LossType extends DataClass implements Insertable<LossType> {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const LossType({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LossTypesCompanion toCompanion(bool nullToAbsent) {
    return LossTypesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LossType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LossType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LossType copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LossType(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LossType copyWithCompanion(LossTypesCompanion data) {
    return LossType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LossType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LossType &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LossTypesCompanion extends UpdateCompanion<LossType> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const LossTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LossTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<LossType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LossTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return LossTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LossTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CashRegistersTable cashRegisters = $CashRegistersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $PaymentMethodsTable paymentMethods = $PaymentMethodsTable(this);
  late final $IncomesTable incomes = $IncomesTable(this);
  late final $ProductSubproductsTable productSubproducts =
      $ProductSubproductsTable(this);
  late final $InventoryLossesTable inventoryLosses = $InventoryLossesTable(
    this,
  );
  late final $LossTypesTable lossTypes = $LossTypesTable(this);
  late final PaymentMethodDao paymentMethodDao = PaymentMethodDao(
    this as AppDatabase,
  );
  late final CashRegisterDao cashRegisterDao = CashRegisterDao(
    this as AppDatabase,
  );
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final ProductSubproductDao productSubproductDao = ProductSubproductDao(
    this as AppDatabase,
  );
  late final PurchaseDao purchaseDao = PurchaseDao(this as AppDatabase);
  late final SaleDao saleDao = SaleDao(this as AppDatabase);
  late final ExpenseDao expenseDao = ExpenseDao(this as AppDatabase);
  late final IncomeDao incomeDao = IncomeDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    cashRegisters,
    categories,
    expenses,
    purchases,
    sales,
    paymentMethods,
    incomes,
    productSubproducts,
    inventoryLosses,
    lossTypes,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      Value<String?> description,
      Value<double> salePrice,
      Value<double> stock,
      Value<bool> trackStock,
      Value<bool> hasSubProducts,
      Value<AppActiveStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<String?> description,
      Value<double> salePrice,
      Value<double> stock,
      Value<bool> trackStock,
      Value<bool> hasSubProducts,
      Value<AppActiveStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get trackStock => $composableBuilder(
    column: $table.trackStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasSubProducts => $composableBuilder(
    column: $table.hasSubProducts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppActiveStatus, AppActiveStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get trackStock => $composableBuilder(
    column: $table.trackStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasSubProducts => $composableBuilder(
    column: $table.hasSubProducts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<double> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<bool> get trackStock => $composableBuilder(
    column: $table.trackStock,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasSubProducts => $composableBuilder(
    column: $table.hasSubProducts,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AppActiveStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<double> stock = const Value.absent(),
                Value<bool> trackStock = const Value.absent(),
                Value<bool> hasSubProducts = const Value.absent(),
                Value<AppActiveStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                salePrice: salePrice,
                stock: stock,
                trackStock: trackStock,
                hasSubProducts: hasSubProducts,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<double> stock = const Value.absent(),
                Value<bool> trackStock = const Value.absent(),
                Value<bool> hasSubProducts = const Value.absent(),
                Value<AppActiveStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                salePrice: salePrice,
                stock: stock,
                trackStock: trackStock,
                hasSubProducts: hasSubProducts,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$CashRegistersTableCreateCompanionBuilder =
    CashRegistersCompanion Function({
      Value<int> id,
      Value<DateTime> registerDate,
      Value<double> openingAmount,
      Value<double?> closingAmount,
      Value<double> totalIncome,
      Value<double> totalExpenses,
      Value<CashRegisterStatus> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$CashRegistersTableUpdateCompanionBuilder =
    CashRegistersCompanion Function({
      Value<int> id,
      Value<DateTime> registerDate,
      Value<double> openingAmount,
      Value<double?> closingAmount,
      Value<double> totalIncome,
      Value<double> totalExpenses,
      Value<CashRegisterStatus> status,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$CashRegistersTableFilterComposer
    extends Composer<_$AppDatabase, $CashRegistersTable> {
  $$CashRegistersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registerDate => $composableBuilder(
    column: $table.registerDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get openingAmount => $composableBuilder(
    column: $table.openingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get closingAmount => $composableBuilder(
    column: $table.closingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalIncome => $composableBuilder(
    column: $table.totalIncome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CashRegisterStatus, CashRegisterStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashRegistersTableOrderingComposer
    extends Composer<_$AppDatabase, $CashRegistersTable> {
  $$CashRegistersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registerDate => $composableBuilder(
    column: $table.registerDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get openingAmount => $composableBuilder(
    column: $table.openingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get closingAmount => $composableBuilder(
    column: $table.closingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalIncome => $composableBuilder(
    column: $table.totalIncome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashRegistersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashRegistersTable> {
  $$CashRegistersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get registerDate => $composableBuilder(
    column: $table.registerDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get openingAmount => $composableBuilder(
    column: $table.openingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get closingAmount => $composableBuilder(
    column: $table.closingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalIncome => $composableBuilder(
    column: $table.totalIncome,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CashRegisterStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CashRegistersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashRegistersTable,
          CashRegister,
          $$CashRegistersTableFilterComposer,
          $$CashRegistersTableOrderingComposer,
          $$CashRegistersTableAnnotationComposer,
          $$CashRegistersTableCreateCompanionBuilder,
          $$CashRegistersTableUpdateCompanionBuilder,
          (
            CashRegister,
            BaseReferences<_$AppDatabase, $CashRegistersTable, CashRegister>,
          ),
          CashRegister,
          PrefetchHooks Function()
        > {
  $$CashRegistersTableTableManager(_$AppDatabase db, $CashRegistersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashRegistersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashRegistersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashRegistersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> registerDate = const Value.absent(),
                Value<double> openingAmount = const Value.absent(),
                Value<double?> closingAmount = const Value.absent(),
                Value<double> totalIncome = const Value.absent(),
                Value<double> totalExpenses = const Value.absent(),
                Value<CashRegisterStatus> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CashRegistersCompanion(
                id: id,
                registerDate: registerDate,
                openingAmount: openingAmount,
                closingAmount: closingAmount,
                totalIncome: totalIncome,
                totalExpenses: totalExpenses,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> registerDate = const Value.absent(),
                Value<double> openingAmount = const Value.absent(),
                Value<double?> closingAmount = const Value.absent(),
                Value<double> totalIncome = const Value.absent(),
                Value<double> totalExpenses = const Value.absent(),
                Value<CashRegisterStatus> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CashRegistersCompanion.insert(
                id: id,
                registerDate: registerDate,
                openingAmount: openingAmount,
                closingAmount: closingAmount,
                totalIncome: totalIncome,
                totalExpenses: totalExpenses,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashRegistersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashRegistersTable,
      CashRegister,
      $$CashRegistersTableFilterComposer,
      $$CashRegistersTableOrderingComposer,
      $$CashRegistersTableAnnotationComposer,
      $$CashRegistersTableCreateCompanionBuilder,
      $$CashRegistersTableUpdateCompanionBuilder,
      (
        CashRegister,
        BaseReferences<_$AppDatabase, $CashRegistersTable, CashRegister>,
      ),
      CashRegister,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<AppActiveStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<AppActiveStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppActiveStatus, AppActiveStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AppActiveStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<AppActiveStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                description: description,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<AppActiveStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<int?> cashRegisterId,
      required String description,
      Value<double> amount,
      Value<RecordStatus> status,
      Value<DateTime> expenseDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<int?> cashRegisterId,
      Value<String> description,
      Value<double> amount,
      Value<RecordStatus> status,
      Value<DateTime> expenseDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordStatus, RecordStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecordStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                cashRegisterId: cashRegisterId,
                description: description,
                amount: amount,
                status: status,
                expenseDate: expenseDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                required String description,
                Value<double> amount = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                cashRegisterId: cashRegisterId,
                description: description,
                amount: amount,
                status: status,
                expenseDate: expenseDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      required int productId,
      Value<int?> cashRegisterId,
      required int paymentMethodId,
      required String aliasProductName,
      Value<double> quantity,
      Value<double> totalCost,
      Value<DateTime> purchaseDate,
      Value<String?> notes,
      Value<bool> isSoldOut,
      Value<RecordStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int?> cashRegisterId,
      Value<int> paymentMethodId,
      Value<String> aliasProductName,
      Value<double> quantity,
      Value<double> totalCost,
      Value<DateTime> purchaseDate,
      Value<String?> notes,
      Value<bool> isSoldOut,
      Value<RecordStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aliasProductName => $composableBuilder(
    column: $table.aliasProductName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSoldOut => $composableBuilder(
    column: $table.isSoldOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordStatus, RecordStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aliasProductName => $composableBuilder(
    column: $table.aliasProductName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSoldOut => $composableBuilder(
    column: $table.isSoldOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aliasProductName => $composableBuilder(
    column: $table.aliasProductName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isSoldOut =>
      $composableBuilder(column: $table.isSoldOut, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecordStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
          Purchase,
          PrefetchHooks Function()
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                Value<int> paymentMethodId = const Value.absent(),
                Value<String> aliasProductName = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isSoldOut = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                productId: productId,
                cashRegisterId: cashRegisterId,
                paymentMethodId: paymentMethodId,
                aliasProductName: aliasProductName,
                quantity: quantity,
                totalCost: totalCost,
                purchaseDate: purchaseDate,
                notes: notes,
                isSoldOut: isSoldOut,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                Value<int?> cashRegisterId = const Value.absent(),
                required int paymentMethodId,
                required String aliasProductName,
                Value<double> quantity = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isSoldOut = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                productId: productId,
                cashRegisterId: cashRegisterId,
                paymentMethodId: paymentMethodId,
                aliasProductName: aliasProductName,
                quantity: quantity,
                totalCost: totalCost,
                purchaseDate: purchaseDate,
                notes: notes,
                isSoldOut: isSoldOut,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
      Purchase,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required int productId,
      Value<int?> purchaseId,
      Value<int?> cashRegisterId,
      required int paymentMethodId,
      required String aliasProductName,
      Value<double> quantity,
      Value<double> totalPrice,
      Value<String?> notes,
      Value<RecordStatus> status,
      Value<DateTime> saleDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int?> purchaseId,
      Value<int?> cashRegisterId,
      Value<int> paymentMethodId,
      Value<String> aliasProductName,
      Value<double> quantity,
      Value<double> totalPrice,
      Value<String?> notes,
      Value<RecordStatus> status,
      Value<DateTime> saleDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aliasProductName => $composableBuilder(
    column: $table.aliasProductName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordStatus, RecordStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aliasProductName => $composableBuilder(
    column: $table.aliasProductName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentMethodId => $composableBuilder(
    column: $table.paymentMethodId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aliasProductName => $composableBuilder(
    column: $table.aliasProductName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecordStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get saleDate =>
      $composableBuilder(column: $table.saleDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
          Sale,
          PrefetchHooks Function()
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> purchaseId = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                Value<int> paymentMethodId = const Value.absent(),
                Value<String> aliasProductName = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> saleDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                productId: productId,
                purchaseId: purchaseId,
                cashRegisterId: cashRegisterId,
                paymentMethodId: paymentMethodId,
                aliasProductName: aliasProductName,
                quantity: quantity,
                totalPrice: totalPrice,
                notes: notes,
                status: status,
                saleDate: saleDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                Value<int?> purchaseId = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                required int paymentMethodId,
                required String aliasProductName,
                Value<double> quantity = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> saleDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                productId: productId,
                purchaseId: purchaseId,
                cashRegisterId: cashRegisterId,
                paymentMethodId: paymentMethodId,
                aliasProductName: aliasProductName,
                quantity: quantity,
                totalPrice: totalPrice,
                notes: notes,
                status: status,
                saleDate: saleDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
      Sale,
      PrefetchHooks Function()
    >;
typedef $$PaymentMethodsTableCreateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<int> displayOrder,
      Value<AppActiveStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$PaymentMethodsTableUpdateCompanionBuilder =
    PaymentMethodsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<int> displayOrder,
      Value<AppActiveStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$PaymentMethodsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AppActiveStatus, AppActiveStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentMethodsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentMethodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentMethodsTable> {
  $$PaymentMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AppActiveStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PaymentMethodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentMethodsTable,
          PaymentMethod,
          $$PaymentMethodsTableFilterComposer,
          $$PaymentMethodsTableOrderingComposer,
          $$PaymentMethodsTableAnnotationComposer,
          $$PaymentMethodsTableCreateCompanionBuilder,
          $$PaymentMethodsTableUpdateCompanionBuilder,
          (
            PaymentMethod,
            BaseReferences<_$AppDatabase, $PaymentMethodsTable, PaymentMethod>,
          ),
          PaymentMethod,
          PrefetchHooks Function()
        > {
  $$PaymentMethodsTableTableManager(
    _$AppDatabase db,
    $PaymentMethodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<AppActiveStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => PaymentMethodsCompanion(
                id: id,
                name: name,
                description: description,
                displayOrder: displayOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<AppActiveStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => PaymentMethodsCompanion.insert(
                id: id,
                name: name,
                description: description,
                displayOrder: displayOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentMethodsTable,
      PaymentMethod,
      $$PaymentMethodsTableFilterComposer,
      $$PaymentMethodsTableOrderingComposer,
      $$PaymentMethodsTableAnnotationComposer,
      $$PaymentMethodsTableCreateCompanionBuilder,
      $$PaymentMethodsTableUpdateCompanionBuilder,
      (
        PaymentMethod,
        BaseReferences<_$AppDatabase, $PaymentMethodsTable, PaymentMethod>,
      ),
      PaymentMethod,
      PrefetchHooks Function()
    >;
typedef $$IncomesTableCreateCompanionBuilder =
    IncomesCompanion Function({
      Value<int> id,
      Value<int?> cashRegisterId,
      required double amount,
      required String description,
      Value<RecordStatus> status,
      Value<DateTime> incomeDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$IncomesTableUpdateCompanionBuilder =
    IncomesCompanion Function({
      Value<int> id,
      Value<int?> cashRegisterId,
      Value<double> amount,
      Value<String> description,
      Value<RecordStatus> status,
      Value<DateTime> incomeDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$IncomesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordStatus, RecordStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get incomeDate => $composableBuilder(
    column: $table.incomeDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncomesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get incomeDate => $composableBuilder(
    column: $table.incomeDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RecordStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get incomeDate => $composableBuilder(
    column: $table.incomeDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$IncomesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomesTable,
          Income,
          $$IncomesTableFilterComposer,
          $$IncomesTableOrderingComposer,
          $$IncomesTableAnnotationComposer,
          $$IncomesTableCreateCompanionBuilder,
          $$IncomesTableUpdateCompanionBuilder,
          (Income, BaseReferences<_$AppDatabase, $IncomesTable, Income>),
          Income,
          PrefetchHooks Function()
        > {
  $$IncomesTableTableManager(_$AppDatabase db, $IncomesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> incomeDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => IncomesCompanion(
                id: id,
                cashRegisterId: cashRegisterId,
                amount: amount,
                description: description,
                status: status,
                incomeDate: incomeDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                required double amount,
                required String description,
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> incomeDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => IncomesCompanion.insert(
                id: id,
                cashRegisterId: cashRegisterId,
                amount: amount,
                description: description,
                status: status,
                incomeDate: incomeDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomesTable,
      Income,
      $$IncomesTableFilterComposer,
      $$IncomesTableOrderingComposer,
      $$IncomesTableAnnotationComposer,
      $$IncomesTableCreateCompanionBuilder,
      $$IncomesTableUpdateCompanionBuilder,
      (Income, BaseReferences<_$AppDatabase, $IncomesTable, Income>),
      Income,
      PrefetchHooks Function()
    >;
typedef $$ProductSubproductsTableCreateCompanionBuilder =
    ProductSubproductsCompanion Function({
      required int productId,
      required int subproductId,
      Value<int> rowid,
    });
typedef $$ProductSubproductsTableUpdateCompanionBuilder =
    ProductSubproductsCompanion Function({
      Value<int> productId,
      Value<int> subproductId,
      Value<int> rowid,
    });

class $$ProductSubproductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductSubproductsTable> {
  $$ProductSubproductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subproductId => $composableBuilder(
    column: $table.subproductId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductSubproductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductSubproductsTable> {
  $$ProductSubproductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subproductId => $composableBuilder(
    column: $table.subproductId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductSubproductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductSubproductsTable> {
  $$ProductSubproductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get subproductId => $composableBuilder(
    column: $table.subproductId,
    builder: (column) => column,
  );
}

class $$ProductSubproductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductSubproductsTable,
          ProductSubproduct,
          $$ProductSubproductsTableFilterComposer,
          $$ProductSubproductsTableOrderingComposer,
          $$ProductSubproductsTableAnnotationComposer,
          $$ProductSubproductsTableCreateCompanionBuilder,
          $$ProductSubproductsTableUpdateCompanionBuilder,
          (
            ProductSubproduct,
            BaseReferences<
              _$AppDatabase,
              $ProductSubproductsTable,
              ProductSubproduct
            >,
          ),
          ProductSubproduct,
          PrefetchHooks Function()
        > {
  $$ProductSubproductsTableTableManager(
    _$AppDatabase db,
    $ProductSubproductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductSubproductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductSubproductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductSubproductsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> productId = const Value.absent(),
                Value<int> subproductId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductSubproductsCompanion(
                productId: productId,
                subproductId: subproductId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int productId,
                required int subproductId,
                Value<int> rowid = const Value.absent(),
              }) => ProductSubproductsCompanion.insert(
                productId: productId,
                subproductId: subproductId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductSubproductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductSubproductsTable,
      ProductSubproduct,
      $$ProductSubproductsTableFilterComposer,
      $$ProductSubproductsTableOrderingComposer,
      $$ProductSubproductsTableAnnotationComposer,
      $$ProductSubproductsTableCreateCompanionBuilder,
      $$ProductSubproductsTableUpdateCompanionBuilder,
      (
        ProductSubproduct,
        BaseReferences<
          _$AppDatabase,
          $ProductSubproductsTable,
          ProductSubproduct
        >,
      ),
      ProductSubproduct,
      PrefetchHooks Function()
    >;
typedef $$InventoryLossesTableCreateCompanionBuilder =
    InventoryLossesCompanion Function({
      Value<int> id,
      required int productId,
      Value<int?> cashRegisterId,
      required int lossTypeId,
      Value<double> quantity,
      Value<String?> description,
      Value<RecordStatus> status,
      Value<DateTime> lossDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$InventoryLossesTableUpdateCompanionBuilder =
    InventoryLossesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int?> cashRegisterId,
      Value<int> lossTypeId,
      Value<double> quantity,
      Value<String?> description,
      Value<RecordStatus> status,
      Value<DateTime> lossDate,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$InventoryLossesTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryLossesTable> {
  $$InventoryLossesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lossTypeId => $composableBuilder(
    column: $table.lossTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecordStatus, RecordStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lossDate => $composableBuilder(
    column: $table.lossDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryLossesTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryLossesTable> {
  $$InventoryLossesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lossTypeId => $composableBuilder(
    column: $table.lossTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lossDate => $composableBuilder(
    column: $table.lossDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryLossesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryLossesTable> {
  $$InventoryLossesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get cashRegisterId => $composableBuilder(
    column: $table.cashRegisterId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lossTypeId => $composableBuilder(
    column: $table.lossTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RecordStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lossDate =>
      $composableBuilder(column: $table.lossDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InventoryLossesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryLossesTable,
          InventoryLossesData,
          $$InventoryLossesTableFilterComposer,
          $$InventoryLossesTableOrderingComposer,
          $$InventoryLossesTableAnnotationComposer,
          $$InventoryLossesTableCreateCompanionBuilder,
          $$InventoryLossesTableUpdateCompanionBuilder,
          (
            InventoryLossesData,
            BaseReferences<
              _$AppDatabase,
              $InventoryLossesTable,
              InventoryLossesData
            >,
          ),
          InventoryLossesData,
          PrefetchHooks Function()
        > {
  $$InventoryLossesTableTableManager(
    _$AppDatabase db,
    $InventoryLossesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryLossesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryLossesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryLossesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> cashRegisterId = const Value.absent(),
                Value<int> lossTypeId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> lossDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => InventoryLossesCompanion(
                id: id,
                productId: productId,
                cashRegisterId: cashRegisterId,
                lossTypeId: lossTypeId,
                quantity: quantity,
                description: description,
                status: status,
                lossDate: lossDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                Value<int?> cashRegisterId = const Value.absent(),
                required int lossTypeId,
                Value<double> quantity = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<RecordStatus> status = const Value.absent(),
                Value<DateTime> lossDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => InventoryLossesCompanion.insert(
                id: id,
                productId: productId,
                cashRegisterId: cashRegisterId,
                lossTypeId: lossTypeId,
                quantity: quantity,
                description: description,
                status: status,
                lossDate: lossDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryLossesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryLossesTable,
      InventoryLossesData,
      $$InventoryLossesTableFilterComposer,
      $$InventoryLossesTableOrderingComposer,
      $$InventoryLossesTableAnnotationComposer,
      $$InventoryLossesTableCreateCompanionBuilder,
      $$InventoryLossesTableUpdateCompanionBuilder,
      (
        InventoryLossesData,
        BaseReferences<
          _$AppDatabase,
          $InventoryLossesTable,
          InventoryLossesData
        >,
      ),
      InventoryLossesData,
      PrefetchHooks Function()
    >;
typedef $$LossTypesTableCreateCompanionBuilder =
    LossTypesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$LossTypesTableUpdateCompanionBuilder =
    LossTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$LossTypesTableFilterComposer
    extends Composer<_$AppDatabase, $LossTypesTable> {
  $$LossTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LossTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $LossTypesTable> {
  $$LossTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LossTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LossTypesTable> {
  $$LossTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LossTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LossTypesTable,
          LossType,
          $$LossTypesTableFilterComposer,
          $$LossTypesTableOrderingComposer,
          $$LossTypesTableAnnotationComposer,
          $$LossTypesTableCreateCompanionBuilder,
          $$LossTypesTableUpdateCompanionBuilder,
          (LossType, BaseReferences<_$AppDatabase, $LossTypesTable, LossType>),
          LossType,
          PrefetchHooks Function()
        > {
  $$LossTypesTableTableManager(_$AppDatabase db, $LossTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LossTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LossTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LossTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LossTypesCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LossTypesCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LossTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LossTypesTable,
      LossType,
      $$LossTypesTableFilterComposer,
      $$LossTypesTableOrderingComposer,
      $$LossTypesTableAnnotationComposer,
      $$LossTypesTableCreateCompanionBuilder,
      $$LossTypesTableUpdateCompanionBuilder,
      (LossType, BaseReferences<_$AppDatabase, $LossTypesTable, LossType>),
      LossType,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CashRegistersTableTableManager get cashRegisters =>
      $$CashRegistersTableTableManager(_db, _db.cashRegisters);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$PaymentMethodsTableTableManager get paymentMethods =>
      $$PaymentMethodsTableTableManager(_db, _db.paymentMethods);
  $$IncomesTableTableManager get incomes =>
      $$IncomesTableTableManager(_db, _db.incomes);
  $$ProductSubproductsTableTableManager get productSubproducts =>
      $$ProductSubproductsTableTableManager(_db, _db.productSubproducts);
  $$InventoryLossesTableTableManager get inventoryLosses =>
      $$InventoryLossesTableTableManager(_db, _db.inventoryLosses);
  $$LossTypesTableTableManager get lossTypes =>
      $$LossTypesTableTableManager(_db, _db.lossTypes);
}
