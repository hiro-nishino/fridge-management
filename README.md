# テーブル設計

## Users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false unique: true |
| encrypted_password | string | null: false              |

### Association

has_many :recipes
has_one :fridge

## Recipes テーブル

| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| title   | string     | null: false                   |
| content | text       | null: false                   |
| user_id | references | null: false foreign_key: true |

### Association

belongs_to :user
has_many :recipe_ingredients
has_many :ingredients, through: :recipe_ingredients
has_many_attached :images
has_many :steps, dependent: :destroy

## Category テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

## Ingredients テーブル

| Column       | Type    | Options        |
| ------------ | ------- | -------------- |
| name         | string  | null: false    |
| quantity     | integer | null: false    |
| is_seasoning | boolean | default: false |
| category_id  | integer | null: false    |

### Association

has_many :recipe_ingredients
has_many :recipes, through: :recipe_ingredients
has_many :fridge_ingredients
has_many :fridges, through: :fridge_ingredients

##　 RecipeIngredients 　テーブル
| Column | Type | Options |
| ------------ | -----------| -------------- |
| recipe_id | references | null: false foreign_key: true |
| ingredient_id | references | null: false foreign_key: true |
| quantity | integer | null: false |

### Association

belongs_to :recipe
belongs_to :ingredient

## Fridges テーブル

| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| user_id | references | null: false foreign_key: true |

### Association

belongs_to :user
has_many :fridge_ingredients
has_many :ingredients, through: :fridge_ingredients

## FridgeIngredients テーブル

| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| recipe_id     | references | null: false foreign_key: true |
| ingredient_id | references | null: false foreign_key: true |
| fridge-id     | references | null: false foreign_key: true |
| quantity      | integer    | null: false                   |

### Association

belongs_to :fridge
belongs_to :ingredient

## steps 　テーブル

| Column    | Type       | Options                       |
| --------- | ---------- | ----------------------------- |
| recipe_id | references | null: false foreign_key: true |
| direction | text       | null: false                   |

### Association

belongs_to :recipe
validates :direction, presence: true

belongs_to :recipe
has_one_attached :step_images
