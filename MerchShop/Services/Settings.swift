//
//  Settings.swift
//  MerchShop
//
//  Created by Trofim Petyanov on 15.02.2022.
//

import Foundation

struct Settings {
    // MARK: – Keys
    enum Setting {
        static let favoriteItems = "favoriteItems"
        static let cartItems = "cartItems"
    }
    
    //MARK: – Shared
    static var shared = Settings()
    private let defaults = UserDefaults.standard
    
    //MARK: – Data
    var collections: [Collection] = [
        Collection(name: "Жаккард", description: "Новая линия мягких повседневных трикотажных изделий отличается геометрическими жаккардовыми узорами в стиле 1960-х годов. Модели идеально подходят для создания многослойных образов и дарят тактильный комфорт.", items: [
            Item(name: "Свитшот с жаккардовыми деталями", description: "Свитшот свободного кроя с круглым вырезом в духе концептуальных моделей, представленных на показе осень-зима 2021, отличается жаккардовыми трикотажными деталями с узорами в стиле 1960-х.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 105000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Двусторонний шарф из жаккарда", description: "жаккардовыми узорами в стиле 1960-х годов, украшающими сторону из шерсти и кашемира. Другая сторона выполнена из переработанного нейлона — инновационного материала, получаемого путем обработки и очистки собранного в океанах пластика.", imageName: "accessory3", sizes: [.oneSize], price: 115000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Жаккардовые перчатки из супертонкой шерсти", description: "Дальнейшее исследование треугольника приводит к созданию новых геометрических форм и оригинальных интерпретаций исторического кода Prada. Украшающий перчатки карман напоминает о легендарной форме. Модели облегающего кроя из шерсти украшены геометрическими жаккардовыми узорами в стиле 1960-х. Они создают эффект «второй кожи», подчеркивая фигуру и обрисовывая силуэт в активном движении. Длинные перчатки, отличающиеся искусной жаккардовой отделкой, входят в линию мягких повседневных трикотажных изделий и аксессуаров, которые идеально подходят для создания многослойных образов и дарят тактильный комфорт.", imageName: "accessory2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 76000, discount: 0, isHotPick: false, isNew: true)
        ]),
        Collection(name: "Re-Nylon", description: "Эстетическая концепция двойственности находит выражение в оригинальном дизайне одежды. Модели выполнены из фирменной ткани бренда в индустриальном стиле — переработанного нейлона, получаемого путем обработки собранного в океане пластика. ", items: [
            Item(name: "Джемпер из нейлона и джерси с круглым вырезом", description: "Свитшот свободного кроя с круглым вырезом, выполненный из джерси и переработанного нейлона, отличается гармоничным контрастом текстур. Нижний край на кулиске создает объем, подчеркивая спортивный стиль. Карман на молнии с эмалированным металлическим треугольным логотипом.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 76000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Брюки из переработанного нейлона", description: "Брюки украшены знаменитым треугольным логотипом из эмалированного металла и выполнены из материала Re-Nylon: эта ткань создана из переработанного нейлонового волокна (ECONYL®), полученного путем переработки и очистки собранного в океанах пластика, рыболовных сетей и текстильных отходов.", imageName: "bottom1", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 125000, discount: 10, isHotPick: false, isNew: false),
            Item(name: "Шорты из переработанного нейлона и джерси", description: "Шорты гибридного дизайна в спортивном стиле выполнены из джерси и переработанного нейлона — волокна, получаемого путем обработки и очистки собранного в океанах пластика, рыболовных сетей и текстильных отходов. Изделие украшено легендарным символом коллекций Prada — треугольным логотипом из эмалированного металла.", imageName: "bottom3", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xxl)], price: 64000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Шорты из Re-Nylon с пайетками", description: "Необычное сочетание спортивного стиля и блестящих пайеток отражает гибридный дух коллекций Prada. Шорты с узором в горох, вышитым переливающимися пайетками, выполнены из переработанного нейлона, получаемого из обработанного и очищенного пластика, собранного в океане. Язык одежды трансформируется: украшения становятся функциональными, а элементы, имеющие практическое применение, обретают декоративный характер.", imageName: "bottom4", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 150000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Джоггеры из Re-Nylon с широкими штанинами", description: "Классические джоггеры в спортивном стиле отличаются интересной игрой объемов, которая создает современный штрих за счет контраста широких штанин и эластичного пояса, подчеркивающего талию. Модель, украшенная фирменным треугольным логотипом из эмалированного металла, выполнена из переработанного нейлона — инновационного материала, получаемого путем обработки и очистки собранного в океанах пластика.", imageName: "bottom5", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 110000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Панама из Re-Nylon", description: "Панама, ставшая легендарным аксессуаром коллекций Prada, выполнена из переработанного нейлона: этот материал создается из переработанного нейлонового волокна (ECONYL®), полученного путем переработки и очистки собранного в океанах пластика, рыболовных сетей и текстильных отходов.", imageName: "accessory6", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 47000, discount: nil, isHotPick: false, isNew: false)
            ]),
    ]
    
    var categories: [Category] = [
        Category(name: "Футболки и свитшоты", items: [
            Item(name: "Укороченный свитшот", description: "Укороченный свитшот из хлопкового флиса с коротким рукавом отличается свободным кроем и выполнен в стиле одежды для активного отдыха. Модель включает эластичный пояс в спортивном уличном стиле и украшена буквенным логотипом в технике интарсия.", imageName: "top1", sizes: [.clothesSize(.xs), .clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 72000, discount: nil, isHotPick: true, isNew: true),
            Item(name: "Свитшот с жаккардовыми деталями", description: "Свитшот свободного кроя с круглым вырезом в духе концептуальных моделей, представленных на показе осень-зима 2021, отличается жаккардовыми трикотажными деталями с узорами в стиле 1960-х.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 105000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Джемпер из нейлона и джерси с круглым вырезом", description: "Свитшот свободного кроя с круглым вырезом, выполненный из джерси и переработанного нейлона, отличается гармоничным контрастом текстур. Нижний край на кулиске создает объем, подчеркивая спортивный стиль. Карман на молнии с эмалированным металлическим треугольным логотипом.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 76000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Укороченный свитшот с принтом", description: "Символы морской тематики и пляжные архетипы — характерные элементы коллекции весна-лето 2022, в которой сочетаются элементы ретростиля и современный крой. Свитшот в актуальном исполнении украшен принтом, напоминающим татуировки моряков, который гармонично сочетается с крупным треугольным логотипом.", imageName: "top2", sizes: [.clothesSize(.xs), .clothesSize(.s), .clothesSize(.l)], price: 83000, discount: nil, isHotPick: true, isNew: false),
            Item(name: "Свитшот с деталями из нейлона", description: "Свитшот свободного кроя отличается непринужденным спортивным характером. Дизайн включает оригинальные детали из нейлона: большой объемный карман, капюшон и кокетку сзади.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 120000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Водолазка из технического джерси", description: "Водолазка из технического джерси, в которой объединились классический минимализм и спортивный стиль, украшена эмалированным металлическим треугольным логотипом — фирменным символом Prada с 1913 года.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 63000, discount: 20, isHotPick: false, isNew: false),
            Item(name: "Футболка из хлопка с принтом", description: "Мужская коллекция весна-лето 2022 обыгрывает архетипы пляжных образов с символами морской тематики, включая якорь, осьминог, русалку и барракуду, выполненные в виде принтов, напоминающих татуировки моряков. Футболка из хлопка свободного кроя с длинным рукавом украшена узором в морском стиле и буквенным логотипом.", imageName: "top2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 72000, discount: nil, isHotPick: false, isNew: false)
        ]),
        Category(name: "Шорты и штаны", items: [
            Item(name: "Брюки из переработанного нейлона", description: "Брюки украшены знаменитым треугольным логотипом из эмалированного металла и выполнены из материала Re-Nylon: эта ткань создана из переработанного нейлонового волокна (ECONYL®), полученного путем переработки и очистки собранного в океанах пластика, рыболовных сетей и текстильных отходов.", imageName: "bottom1", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 125000, discount: 10, isHotPick: false, isNew: false),
            Item(name: "Легкие шерстяные брюки", description: "Брюки карго из легкой шерсти отличаются эластичным поясом и нижним краем, что характерно для классических джоггеров. В своих коллекциях Prada обыгрывает концепцию гибридного дизайна, объединяя в одном изделии противоречивые элементы и создавая нечто оригинальное и неожиданное.", imageName: "bottom2", sizes: [.clothesSize(.xs), .clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 105000, discount: nil, isHotPick: true, isNew: true),
            Item(name: "Шорты из переработанного нейлона и джерси", description: "Шорты гибридного дизайна в спортивном стиле выполнены из джерси и переработанного нейлона — волокна, получаемого путем обработки и очистки собранного в океанах пластика, рыболовных сетей и текстильных отходов. Изделие украшено легендарным символом коллекций Prada — треугольным логотипом из эмалированного металла.", imageName: "bottom3", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xxl)], price: 64000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Шорты из Re-Nylon с пайетками", description: "Необычное сочетание спортивного стиля и блестящих пайеток отражает гибридный дух коллекций Prada. Шорты с узором в горох, вышитым переливающимися пайетками, выполнены из переработанного нейлона, получаемого из обработанного и очищенного пластика, собранного в океане. Язык одежды трансформируется: украшения становятся функциональными, а элементы, имеющие практическое применение, обретают декоративный характер.", imageName: "bottom4", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 150000, discount: nil, isHotPick: false, isNew: false),
            Item(name: "Джоггеры из Re-Nylon с широкими штанинами", description: "Классические джоггеры в спортивном стиле отличаются интересной игрой объемов, которая создает современный штрих за счет контраста широких штанин и эластичного пояса, подчеркивающего талию. Модель, украшенная фирменным треугольным логотипом из эмалированного металла, выполнена из переработанного нейлона — инновационного материала, получаемого путем обработки и очистки собранного в океанах пластика.", imageName: "bottom5", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 110000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Брюки из шерстяного габардина", description: "Широкие брюки спортивного и в то же время утонченного дизайна, выполненные из шерстяного габардина, характеризуются такими элегантными деталями, как пояс на кулиске из того же материала, скошенные прорезные карманы спереди и прорезные карманы с листочкой сзади. Сзади изделие украшено легендарным треугольным логотипом, который был впервые представлен миру в 1913 году на роскошных чемоданах Марио Прады.", imageName: "bottom6", sizes: [.clothesSize(.s), .clothesSize(.l), .clothesSize(.xl)], price: 110000, discount: nil, isHotPick: true, isNew: false),
            Item(name: "Шорты-бермуды из хлопка", description: "Шорты-бермуды из мягкого и легкого хлопка украшены легендарным треугольным логотипом Prada, созданным в 1913 году, в новой интерпретации — в виде текстильной детали.", imageName: "bottom7", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l), .clothesSize(.xl)], price: 125000, discount: 20, isHotPick: true, isNew: false)
        ]),
        Category(name: "Аксессуары", items: [
            Item(name: "Эластичный ремень из кожи наппа", description: "Узкий эластичный ремень из мягкой кожи наппа включает металлическую пряжку, украшенную традиционным эмалированным треугольным логотипом, который впервые был представлен в 1913 году на чемоданах дизайна Марио Прады.", imageName: "accessory1", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 54000, discount: 10, isHotPick: true, isNew: false),
            Item(name: "Жаккардовые перчатки из супертонкой шерсти", description: "Дальнейшее исследование треугольника приводит к созданию новых геометрических форм и оригинальных интерпретаций исторического кода Prada. Украшающий перчатки карман напоминает о легендарной форме. Модели облегающего кроя из шерсти украшены геометрическими жаккардовыми узорами в стиле 1960-х. Они создают эффект «второй кожи», подчеркивая фигуру и обрисовывая силуэт в активном движении. Длинные перчатки, отличающиеся искусной жаккардовой отделкой, входят в линию мягких повседневных трикотажных изделий и аксессуаров, которые идеально подходят для создания многослойных образов и дарят тактильный комфорт.", imageName: "accessory2", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 76000, discount: 0, isHotPick: false, isNew: true),
            Item(name: "Двусторонний шарф из жаккарда", description: "жаккардовыми узорами в стиле 1960-х годов, украшающими сторону из шерсти и кашемира. Другая сторона выполнена из переработанного нейлона — инновационного материала, получаемого путем обработки и очистки собранного в океанах пластика.", imageName: "accessory3", sizes: [.oneSize], price: 115000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Дорожная маска из твила", description: "Дорожная маска — изящный и практичный дорожный аксессуар. Модель из мягкого твила дополнена чехлом на молнии в тон, украшенным фирменным треугольным логотипом из эмалированного металла.", imageName: "accessory4", sizes: [.oneSize], price: 49000, discount: nil, isHotPick: false, isNew: true),
            Item(name: "Чехол для бейджа из металлизированной кожи", description: "Чехол для бейджа, современный универсальный аксессуар, представлен в роскошной версии из металлизированной кожи, воплощающей в себе мастерство бренда. Дальнейшее переосмысление треугольника приводит к созданию новых геометрических форм и уникальных интерпретаций исторического символа Prada. Легендарная форма находит отражение в узоре, украшающем поверхность с эффектом сияющих граней.", imageName: "accessory5", sizes: [.oneSize], price: 61000, discount: 20, isHotPick: true, isNew: false),
            Item(name: "Панама из Re-Nylon", description: "Панама, ставшая легендарным аксессуаром коллекций Prada, выполнена из переработанного нейлона: этот материал создается из переработанного нейлонового волокна (ECONYL®), полученного путем переработки и очистки собранного в океанах пластика, рыболовных сетей и текстильных отходов.", imageName: "accessory6", sizes: [.clothesSize(.s), .clothesSize(.m), .clothesSize(.l)], price: 47000, discount: nil, isHotPick: false, isNew: false)
        ])
    ]
    
    var favoriteItems: [Item] {
        get {
            return unarchiveJSON(key: Setting.favoriteItems) ?? []
        } set {
            archiveJSON(value: newValue, key: Setting.favoriteItems)
        }
    }
    
    var cartItems: [Item] {
        get {
            return unarchiveJSON(key: Setting.cartItems) ?? []
        } set {
            archiveJSON(value: newValue, key: Setting.cartItems)
        }
    }
    
    //MARK: – Encoding & Decoding
    private func archiveJSON<T: Encodable>(value: T, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            let string = String(data: data, encoding: .utf8)
            defaults.set(string, forKey: key)
        } catch {
            debugPrint("Error occured when encoding data")
        }
    }
    
    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        guard let string = defaults.string(forKey: key), let data = string.data(using: .utf8) else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            debugPrint("Error occured when decoding data")
            return nil
        }
    }
}
