import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mebel UZ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedCategoryIndex = 0;

  final List<String> categories = [
    'Barchasi',
    'Stollar',
    'Stullar',
    'Divanlar',
    'Shkaf',
    'Yotoq',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Zamonaviy stol',
      'category': 'Stollar',
      'price': '2,500,000',
      'image': '🪑',
      'description': 'Zamonaviy dizaynli oshxona stoli, yog\'och materialdan yasalgan',
      'rating': 4.5,
    },
    {
      'name': 'Qulay stul',
      'category': 'Stullar',
      'price': '450,000',
      'image': '🪑',
      'description': 'Qulay va chiroyli stul, uy va ofis uchun',
      'rating': 4.2,
    },
    {
      'name': 'Lux divan',
      'category': 'Divanlar',
      'price': '3,800,000',
      'image': '🛋️',
      'description': 'Luxury divan, oila uchun qulay',
      'rating': 4.8,
    },
    {
      'name': 'Garderob shkaf',
      'category': 'Shkaf',
      'price': '1,200,000',
      'image': '🚪',
      'description': 'Katta garderob shkafi, barcha kiyimlar uchun',
      'rating': 4.3,
    },
    {
      'name': 'Yotoq to\'shagi',
      'category': 'Yotoq',
      'price': '1,500,000',
      'image': '🛏️',
      'description': 'Qulay yotoq to\'shagi, yaxshi uyqu uchun',
      'rating': 4.6,
    },
    {
      'name': 'Oshxona stoli',
      'category': 'Stollar',
      'price': '3,200,000',
      'image': '🪑',
      'description': 'Katta oshxona stoli, oila uchun',
      'rating': 4.4,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (_searchQuery.isEmpty && _selectedCategoryIndex == 0) {
      return products;
    }
    
    return products.where((product) {
      bool matchesSearch = product['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          product['description'].toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesCategory = _selectedCategoryIndex == 0 || 
                           product['category'] == categories[_selectedCategoryIndex];
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mebel UZ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Mebel qidirish...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: _selectedCategoryIndex == index,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryIndex = selected ? index : 0;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Products count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProducts.length} ta mahsulot topildi',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Barchasi',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Products list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          product['image'],
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    title: Text(
                      product['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          product['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product['rating'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${product['price']} so\'m',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            _showProductDetails(context, product);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Batafsil'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    product['image'],
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Kategoriya: ${product['category']}'),
            const SizedBox(height: 8),
            Text('Narxi: ${product['price']} so\'m'),
            const SizedBox(height: 8),
            Text('Reyting: ${product['rating']} ⭐'),
            const SizedBox(height: 16),
            Text(
              'Tavsif:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product['description']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yopish'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showOrderDialog(context, product);
            },
            child: const Text('Buyurtma berish'),
          ),
        ],
      ),
    );
  }

  void _showOrderDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buyurtma berish'),
        content: const Text('Buyurtmangiz qabul qilindi! Tez orada siz bilan bog\'lanamiz.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yaxshi'),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yangi mahsulot qo\'shish'),
        content: const Text('Bu funksiya keyinchalik qo\'shiladi.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tushundim'),
          ),
        ],
      ),
    );
  }
}
