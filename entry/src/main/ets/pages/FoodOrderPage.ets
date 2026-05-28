import { FoodCategory, Food, CartItem } from '../models/FoodModel';
import { ApiService } from '../services/ApiService';
import FoodList from '../components/FoodList';
import ShoppingCart from '../components/ShoppingCart';

@Entry
@Component
struct FoodOrderPage {
  @State foodCategories: FoodCategory[] = [];
  @State cartItems: CartItem[] = [];
  @State totalPrice: number = 0;
  @State showCart: boolean = false;
  @State loading: boolean = true;
  @State errorMessage: string = '';
  @State scroller: Scroller = new Scroller();

  aboutToAppear() {
    this.loadFoodsData();
  }

  /**
   * 加载食品数据
   */
  loadFoodsData() {
    this.loading = true;
    this.errorMessage = '';
    ApiService.getFoodsList()
      .then((data) => {
        this.foodCategories = data;
        // 初始化购物车数量
        this.foodCategories.forEach(category => {
          category.foods.forEach(food => {
            food.cartCount = 0;
          });
        });
        this.loading = false;
      })
      .catch((err) => {
        this.errorMessage = `加载失败: ${err.message}`;
        this.loading = false;
      });
  }

  /**
   * 添加食品到购物车
   */
  addToCart(food: Food) {
    food.cartCount = (food.cartCount || 0) + 1;
    let existItem = this.cartItems.find(item => item.id === food.id);
    if (existItem) {
      existItem.cartCount++;
    } else {
      this.cartItems.push({
        ...food,
        cartCount: 1
      });
    }
    this.updateTotalPrice();
  }

  /**
   * 从购物车移除食品
   */
  removeFromCart(food: Food) {
    if (!food.cartCount || food.cartCount <= 0) return;

    food.cartCount--;
    let cartIndex = this.cartItems.findIndex(item => item.id === food.id);
    if (cartIndex !== -1) {
      if (this.cartItems[cartIndex].cartCount > 0) {
        this.cartItems[cartIndex].cartCount--;
      } else {
        this.cartItems.splice(cartIndex, 1);
      }
    }
    this.updateTotalPrice();
  }

  /**
   * ��空购物车
   */
  clearCart() {
    this.cartItems = [];
    this.foodCategories.forEach(category => {
      category.foods.forEach(food => {
        food.cartCount = 0;
      });
    });
    this.updateTotalPrice();
    this.showCart = false;
  }

  /**
   * 更新总价
   */
  updateTotalPrice() {
    this.totalPrice = this.cartItems.reduce((sum, item) => {
      return sum + item.price * item.cartCount;
    }, 0);
  }

  /**
   * 切换购物车显示
   */
  toggleCart() {
    this.showCart = !this.showCart;
  }

  build() {
    Column() {
      // 头部
      Row() {
        Text('外卖点餐')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.font_main_color'))
      }
      .width('100%')
      .height(56)
      .padding(16)
      .backgroundColor($r('app.color.left_back_color'))

      // 加载状态
      if (this.loading) {
        Column() {
          LoadingProgress()
            .width(50)
            .height(50)
          Text('加载中...')
            .margin({ top: 16 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else if (this.errorMessage) {
        // 错误状态
        Column() {
          Text('加载失败')
            .fontSize(16)
            .fontColor($r('app.color.font_main_color'))
          Text(this.errorMessage)
            .fontSize(12)
            .fontColor('#999')
            .margin({ top: 8 })
          Button('重试')
            .margin({ top: 16 })
            .onClick(() => this.loadFoodsData())
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        // 食品列表
        Row() {
          FoodList({
            categories: $foodCategories,
            onAddToCart: (food: Food) => this.addToCart(food),
            onRemoveFromCart: (food: Food) => this.removeFromCart(food)
          })
        }
        .width('100%')
        .layoutWeight(1)
      }

      // 底部购物车
      Row() {
        // 购物车总价
        Column() {
          Text('¥' + this.totalPrice.toFixed(2))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.main_color'))
        }
        .layoutWeight(1)
        .padding(16)

        // 购物车按钮
        Button() {
          Column() {
            if (this.cartItems.length > 0) {
              Text(this.cartItems.length.toString())
                .fontSize(14)
                .fontColor($r('app.color.white'))
                .position({ x: -6, y: -6 })
                .backgroundColor($r('app.color.font_main_color'))
                .borderRadius(10)
                .width(20)
                .height(20)
                .textAlign(TextAlign.Center)
            }
            Text('🛵')
              .fontSize(24)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width(60)
        .height(60)
        .backgroundColor($r('app.color.bottom_back'))
        .borderRadius(30)
        .onClick(() => this.toggleCart())
      }
      .width('100%')
      .height(80)
      .backgroundColor($r('app.color.bottom_back'))
      .alignItems(VerticalAlign.Center)

      // 购物车弹窗
      if (this.showCart) {
        ShoppingCart({
          items: $cartItems,
          onRemove: (food: Food) => this.removeFromCart(food),
          onAdd: (food: Food) => this.addToCart(food),
          onClear: () => this.clearCart(),
          onClose: () => this.toggleCart()
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.white'))
  }
}