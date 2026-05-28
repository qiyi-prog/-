// 食品数据模型
export interface Food {
  id: number;
  name: string;
  like_ratio_desc: string;
  month_saled: number;
  unit: string;
  food_tag_list: string[];
  price: number;
  picture: string;
  description: string;
  tag: string;
  count: number;
  cartCount?: number; // 购物车中的数量
}

export interface FoodCategory {
  tag: string;
  name: string;
  foods: Food[];
}

export interface CartItem extends Food {
  cartCount: number;
}