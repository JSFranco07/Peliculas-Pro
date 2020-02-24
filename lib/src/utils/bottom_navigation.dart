import 'package:flutter/material.dart';

enum TabItem {inicio, peliculas, series}

//Asignar nombres a cada boton dela barra
Map<TabItem, String> tabName = {
  TabItem.inicio: 'Inicio',
  TabItem.peliculas: 'Peliculas',
  TabItem.series: 'Series',
};

Map<TabItem, MaterialColor> tabColor ={
  TabItem.inicio: Colors.red,
  TabItem.peliculas: Colors.green,
  TabItem.series: Colors.blue
};

//Asignar iconos a cada boton de la barra
Map<TabItem, IconData> tabIcon ={
  TabItem.inicio: Icons.home,
  TabItem.peliculas: Icons.movie,
  TabItem.series: Icons.live_tv
};

class BottomNavigation extends StatelessWidget {

  BottomNavigation({this.currentTab, this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _crearItem(tabItem: TabItem.inicio),
        _crearItem(tabItem: TabItem.peliculas),
        _crearItem(tabItem: TabItem.series),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _crearItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = tabIcon[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        icon, color: _colorTabMatching(item: tabItem)
      ),
      title: Text(
        text, 
        style: TextStyle(
          color: _colorTabMatching(item: tabItem)
        )
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? tabColor[item] : Colors.grey;
  }
}