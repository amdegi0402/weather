
import 'package:flutter/material.dart';
import 'package:hello/select_mount_data/select_page_top_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/select_mount_data/select_page.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';





class SelectPageTop extends StatelessWidget {
  
  Map<String, List<String>> _dropDownMenu = {
    '福岡': ['宝満山', '英彦山', '立石山', '大平山', '背振山', '金山', '福知山', '雷山', '基山', '三郡山', '二丈岳', '貫山', '立花山', '可也山', '若杉山', '皿倉山', '井原山', '犬ヶ岳', '障子ヶ岳', '古処山', '足立山', '笠置山', '鷹取山', '九千部山', '十坊山', '釈迦ケ岳', '三池山', '六ケ岳', '求菩提山', '大城山', '馬見山', '叶岳', '城山', '犬鳴山', '尺岳', '鳥屋山', '浮嶽', '大根地山', '鷹ノ巣山', '砥上岳', '龍王山', '雁股山', '風師山', '岩石山', '岳滅鬼山', '大法山', '孔大寺山', '発心山', 'カラ迫岳', '牛斬山', '石割岳', '鬼ケ鼻岩', '荒平山', '石谷山'],
    '佐賀': ['黒髪山', '多良岳', '経ヶ岳','天山', '作礼山', '金立山','鏡山', '八幡岳', '日ノ隈山','土器山', '御船山', '蛤岳','青螺山', '鎮西山', '聖岳','衣干山', '白岩山', '金敷城山','彦岳', '腰岳', '通石山','徳連岳', '両子山', '牧ノ山','柏岳', '杓子ヶ峰', '唐泉山','英山', '椿山', '犬山岳','蓮華石山', '亀岳', '岸岳','人形石山'],
    '長崎': ['雲仙岳', '八郎岳', '金比羅山', '虚空蔵山', '稲佐山', '英彦山', '岩屋山', '烽火山', '五家原岳', '国見山', '郡岳', '九千部岳', '琴ノ尾岳', '弓張岳', '白岳', '帆場岳', '虚空蔵山', '鬼岳', '烏帽子岳', '眉山', '有明山', '志々伎山', '隠居岳', '矢岳', '御岳', '吾妻岳', '唐八景', '熊ヶ峰', '安満岳', '野岳', '松尾岳', '猪見岳', '城山', '猿葉山', '竜良山', '大野岳', '鳥甲岳', '七ツ岳', '野岳', '冷水岳', '人形石山', '韮岳', '遠見山', '稗ノ岳', '佐志岳', '上床高原'],
    '大分': ['由布岳', '久住山', '涌蓋山', '大船山', '鶴見岳', '黒岳', '三俣山', '中岳', '万年山', '傾山', '平治岳', '倉木山', '釈迦ヶ岳', '星生山', '酒呑童子山', '福万山', '鹿嵐山', '鷹ノ巣山', '中山仙境', '稲星山', '元越山', '雁股山', '津波戸山', '檜原山', '大障子岩', '泉水山', '古祖母山', '大平山', '熊群山', '岳滅鬼山', '樋桶山', '彦岳', '花牟礼山', '渡神岳', '障子岳', '木山内岳', '夏木山', '肥前ヶ城', '緩木山', '平家山', '千灯岳', '宇曽山'],
    '熊本': ['市房山', '阿蘇山', '俵山', '根子岳', '国見岳', '白髪岳', '八方ヶ岳', '鞍岳', '雁回山', '龍ヶ岳', '小岱山', '杵島岳', '三国山', '白鳥山', '矢筈岳', '三角岳', '次郎丸獄', '仰烏帽子山', '冠ヶ岳', '烏帽子岳', '角山', '上福根山', '天主山', '向坂山', '二ノ岳', '洞ヶ岳', '京丈山', '夜峰山', '竜峰山', '権現山', '染岳', '倉岳', '笠山', '小川岳', '目丸山', '柴尾山', '保口岳', '染岳', '大矢野岳', '一ノ峯', '念珠岳', '頭岳', '蕗岳'],
    '宮崎': ['高千穂峰', '韓国岳', '祖母山', '市房山', '行縢山', '大崩山' ,'白鳥山', '双石山', '国見岳', '栗野岳', '霧島山', '比叡山', '諸塚山', '尾鈴山', '地蔵岳', '鉾岳', '釈迦ケ岳', '鰐塚山', '石堂山', '扇山', '中岳', '黒岳', '大幡山', '冠岳', '五葉岳', '可愛岳', '双石山', '赤川浦岳', '鹿納山', '斟鉢山', '桑原山', '牛の峠', '式部岳', '矢筈岳', '樋口山', '釣鐘山', '三方岳', '笹ノ峠', '祇園山', '日隠山', '玄武山', '馬口岳'],
    '鹿児島': ['開聞岳', '宮之浦岳', 'モッチョム岳', '金峰山', '高隅山', '八重山', '紫尾山', '黒味岳', '冠岳', '藺牟田池外輪山', '鳥帽子岳', '野間岳', '御岳', '御在所岳', '中岳（鹿児島）', '横岳', '磯間嶽', '太忠岳', '新燃岳', '木場岳', '甫与志岳', '花尾山', '愛子岳', '三重嶽', '稲尾岳', '下山岳', '鬼門平', '矢筈岳', '長尾山', '辻岳', '白山', '清見岳', '母ヶ岳', '鷹ノ子岳', '草野岳', '鳥神岡', '八山岳', '石堂山', '摺ヶ丘', '荒西山', '黒尊岳', '六郎館岳', '櫓岳', '遠目木山'],
    '沖縄': ['与那覇岳', '嘉津宇岳', '石川岳', '名護岳', '古見岳', 'ネクマチヂ岳', '於茂登岳', '安和岳', '宇良部岳', '古巣岳', 'だるま山', '野底岳', 'ぶざま岳', 'ウマヌファ岳', 'バンナ岳', '宇江城岳', '屋良部岳', '前嵩'],
  };



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<MainModel>(create:(context) => MainModel(),),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('YAMA TENKI'),
            centerTitle: true,
          ),
          body: Consumer<MainModel>(builder: (context, model, child){
            return Column(
          children: <Widget>[
         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '県名を選択してください',
                style: TextStyle(fontSize: 20),
              ),
              DropdownButton<String>(
                value: model.getColection(),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(fontSize: 20, color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (newValue) {
                  model.getColection() != null ? model.setDocument(null) : print("OK");
                  model.setColection(newValue);
                  model.setVisible(false);
                },
                items: _dropDownMenu.keys
                  .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          
          model.getColection() != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '山を選択',
                  style: TextStyle(fontSize: 20),
                ),
                
                DropdownButton<String>(
                  value: model.getDocument(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  elevation: 16,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (newValue) {
                      model.setDocument(newValue); //provider Main
                      model.setVisible(true);
                  },
                  items: _dropDownMenu[model.getColection()]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      
                    );
                    
                  }).toList(),
                ),
                
              ], 
            )
          : Container(),
          
          Visibility( //button 表示・非表示　アイテムが選択されていれば表示
            child:
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectPage(selectColection: model.getColection(), selectDocument: model.getDocument())),
                  );
                },
                child: Text('OK'),
              ),
            visible: model.getVisible(),
          ),   
        
        ],
      );
          })
        )
      ) 
    );
  }
}


