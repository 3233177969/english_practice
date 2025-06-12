export const bannerList: Array<Resource> = [
  $r('app.media.banner1'),
  $r('app.media.banner2'),
  $r('app.media.banner3')
]

export class LevelBean {
  title: string = '';
  des: string = '';
  bgColor: Resource = $r('app.color.level1_color');
}

export const homeLevelList: LevelBean[] = [
  {
    title: "大学英语四级（CET-4）",
    des: "面向非英语专业本科生，每年举行两次，是评估学生基础英语能力的重要考试。",
    bgColor: $r('app.color.level1_color')
  },
  {
    title: "大学英语六级（CET-6）",
    des: "在CET-4的基础上，进一步测试学生的英语能力，同样每年举行两次。",
    bgColor: $r('app.color.level2_color')
  },
  {
    title: "雅思（IELTS）",
    des: "雅思考试坚持“沟通为本”的理念，在全球首创从听、说、读、写四方面进行英语能力全面考核的国际考试，能够立体综合地精准测评考生的英语语言运用能力",
    bgColor: $r('app.color.level3_color')
  },
  {
    title: "托福（TOEFL）",
    des: "托福考试是全球认可度最高的语言考试，被全球160多个国家超过12000所综合性大学、机构和学院认可，范围包括美国、加拿大、澳大利亚、新西兰，以及整个欧洲和亚洲",
    bgColor: $r('app.color.level4_color')
  },
  {
    title: "高级英语证书考试(CAE)",
    des: "CAE(Certificate in Advanced English /剑桥高级英语证书考试)，是英国剑桥大学考试委员会根据欧洲委员会制定的语言教学大纲设计的剑桥英语五级证书考试中的第四个等级",
    bgColor: $r('app.color.level5_color')
  }
]

export interface Question {
  word: string; //单词
  sentence: string; //例句
  options: string[]; //选项
  answer: string; //答案
}

//题库
export const questionData: Question[] = [
  {
    word: "book",
    options: ["书籍", "笔", "橡皮", "背包"],
    answer: "书籍",
    sentence: "I love to read a good book every night."
  },
  {
    word: "computer",
    options: ["电视", "电脑", "手机", "相机"],
    answer: "电脑",
    sentence: "I use the computer for work and entertainment."
  },
  {
    word: "apple",
    options: ["香蕉", "桃子", "梨", "苹果"],
    answer: "苹果",
    sentence: "She enjoys eating a crisp apple in the afternoon."
  },
  {
    word: "sun",
    options: ["月亮", "太阳", "星星", "地球"],
    answer: "太阳",
    sentence: "The sun provides warmth and light to our planet."
  },
  {
    word: "water",
    options: ["火", "土地", "风", "水"],
    answer: "水",
    sentence: "I always carry a bottle of water with me."
  },
  {
    word: "mountain",
    options: ["沙漠", "海洋", "平原", "山"],
    answer: "山",
    sentence: "The mountain range is covered in snow during winter."
  },
  {
    word: "flower",
    options: ["树木", "草地", "花", "灌木"],
    answer: "花",
    sentence: "The garden is filled with colorful flowers."
  },
  {
    word: "car",
    options: ["自行车", "飞机", "船", "汽车"],
    answer: "汽车",
    sentence: "I drive my car to work every day."
  },
  {
    word: "time",
    options: ["空间", "时钟", "日历", "时间"],
    answer: "时间",
    sentence: "Time flies when you're having fun."
  },
  {
    word: "music",
    options: ["画", "舞蹈", "音乐", "戏剧"],
    answer: "音乐",
    sentence: "Listening to music helps me relax."
  },
  {
    word: "rain",
    options: ["雪", "雷电", "阳光", "雨"],
    answer: "雨",
    sentence: "I enjoy the sound of rain tapping on the window."
  },
  {
    word: "fire",
    options: ["冰", "火焰", "烟雾", "闪电"],
    answer: "火焰",
    sentence: "The campfire warmed us on a chilly evening."
  },
  {
    word: "friend",
    options: ["陌生人", "邻居", "家人", "朋友"],
    answer: "朋友",
    sentence: "A true friend is always there for you."
  },
  {
    word: "food",
    options: ["水果", "蔬菜", "肉", "食物"],
    answer: "食物",
    sentence: "Healthy food is essential for a balanced diet."
  },
  {
    word: "color",
    options: ["黑色", "白色", "红色", "颜色"],
    answer: "颜色",
    sentence: "The artist used a vibrant color palette."
  },
  {
    word: "bookshelf",
    options: ["椅子", "桌子", "书架", "床"],
    answer: "书架",
    sentence: "The bookshelf is filled with novels and reference books."
  },
  {
    word: "moon",
    options: ["太阳", "星星", "月亮", "地球"],
    answer: "月亮",
    sentence: "The moonlight illuminated the night sky."
  },
  {
    word: "school",
    options: ["公园", "商店", "医院", "学校"],
    answer: "学校",
    sentence: "Students go to school to learn and grow."
  },
  {
    word: "shoes",
    options: ["帽子", "衣服", "裤子", "鞋子"],
    answer: "鞋子",
    sentence: "She bought a new pair of stylish shoes."
  },
  {
    word: "camera",
    options: ["电视", "电脑", "相机", "手机"],
    answer: "相机",
    sentence: "The photographer captured the moment with his camera."
  }
]

//从题库中随机抽取n个题目
export function getRandomQuestions(count: number) {
  let length = questionData.length;

  let indexes: number[] = [];
  while (indexes.length < count) {
    let index = Math.floor(Math.random() * length);
    if (!indexes.includes(index)) {
      indexes.push(index)
    }
  }
  return indexes.map(index => questionData[index])
}