import http from '@ohos.net.http';
import { FoodCategory } from '../models/FoodModel';

export class ApiService {
  private static readonly BASE_URL = 'http://127.0.0.1:3000';

  /**
   * 获取食品列表
   */
  static async getFoodsList(): Promise<FoodCategory[]> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      let url = `${this.BASE_URL}/data/foods`;

      httpRequest.request(url, {
        method: http.RequestMethod.GET,
        connectTimeout: 5000,
        readTimeout: 5000,
        header: {
          'Content-Type': 'application/json'
        }
      }).then((response) => {
        if (response.responseCode === 200) {
          let foodData = JSON.parse(response.result as string) as FoodCategory[];
          resolve(foodData);
        } else {
          reject(new Error(`HTTP Error: ${response.responseCode}`));
        }
      }).catch((err) => {
        reject(err);
      }).finally(() => {
        httpRequest.destroy();
      });
    });
  }
}