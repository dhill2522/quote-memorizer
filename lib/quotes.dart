import 'package:uuid/uuid.dart';
import 'package:localstorage/localstorage.dart';

class Quote {
  Uuid id;
  String title;
  String text;
  String source;
  bool isMemorized;


  Quote(title, text, source, isMemorized) {
    this.id = new Uuid();
    this.title = title;
    this.text = text;
    this.source = source;
    this.isMemorized = isMemorized;
  }

  toJsonEncodeable() {
    Map<String, dynamic> m = new Map();
    m['title'] = this.title;
    m['text'] = this.text;
    m['source'] = this.source;
    m['isMemorized'] = this.isMemorized;
    return m;
  }
}


class QuoteList {
  List<Quote> _list = [];
  final LocalStorage storage = new LocalStorage('quote-memorizer'); 
  bool isReady = false;

  QuoteList() {
    storage.ready.then((ready) {
      storage.setItem('quotes', null); // FIXME: This is
      print('storage is ready: $ready');
      isReady = ready;
      loadList();
      if (_list == null) {
        autopupulateList();
        saveList();
      }
      print('list length: ${_list.length}');
    });

  }

  addQuote(Quote q) {
    _list.add(q);
    saveList();
  }

  removeQuote(Uuid id) {
    _list.removeWhere((el) {
      return el.id == id;
    });
    saveList();
  }

  get length {
    return _list.length;
  }

  getQuotes() {
    return _list;
  }

  saveList() {
    var jsonString = _list.map((el) => el.toJsonEncodeable()).toList();
    storage.ready.then((e) => print('storage status: $e'));
    storage.setItem('quotes', jsonString);
  }

  // sets _list to null on error
  loadList() {
    var data = storage.getItem('quotes');
    print('loaded quotes from storage: $data');
    if (data == null) {
      print('no quotes found. Autopopulating...');
      autopupulateList();
      saveList();
      return;
    }
    try {
      List<dynamic> jsonList = data;
      this._list = jsonList.map((e) {
        return new Quote(e['title'], e['text'], e['source'], e['isMemorized']);
      }).toList();  
    } catch (e) {
      print(e);
      this._list = null;
    }
  }

  autopupulateList() {
    this._list = [
      Quote(
        'First Vision - Importance', 
        'Every claim that we make concerning divine authority, every truth that we offer concerning the validity of the work, all finds its root in the First Vision of the boy prophet. That becomes the hinge pin on which this whole cause turns. If the First Vision was true, if it actually happened, then the Book of Mormon is true. Then we have the priesthood. Then we have the Church organization and all of the other keys and blessings of authority that we say we have. If the First Vision did not occur, then we are involved in a great sham. It is just that simple.', 
        'Gordon B. Hinkley - Teachings of Gordon B. Hinkley(1997), 227', 
        false),
      Quote(
        'Sacrament Prayer - Bread',
        'O God, the Eternal Father, we ask thee in the name of thy Son, Jesus Christ, to bless and sanctify this bread to the souls of all those who partake of it, that they may eat in remembrance of the body of thy Son, and witness unto thee, O God, the Eternal Father, that they are willing to take upon them the name of thy Son, and always remember him and keep his commandments which he has given them; that they may always have his Spirit to be with them. Amen.', 
        'D&C 20:77', 
        false),
      Quote( 
        'Sacrament Prayer - Water',
        'O God, the Eternal Father, we ask thee in the name of thy Son, Jesus Christ, to bless and sanctify this wine to the souls of all those who drink of it, that they may do it in remembrance of the blood of thy Son, which was shed for them; that they may witness unto thee, O God, the Eternal Father, that they do always remember him, that they may have his Spirit to be with them. Amen.', 
        'D&C 20:79', 
        false),
      Quote(
        'Atonement enabled by Ordinances', 
        'Consider the last part of verse 19 [". . . they teach for doctrines the commandments of men, having a form of godliness, but they deny the power thereof"] in connection with the revelations contained in the Doctrine and Covenants: "[For] in the ordinances [of the priesthood], the power of godliness is [made] manifest [unto men in the flesh]. And without the ordinances . . . of the priesthood, the power of godliness is not [made] manifest" (D&C 84:20-21). Consider here that they have "a form of godliness," they have no authority, "but they deny the power thereof." In the ordinances of the holy priesthood, the power of godliness is made manifest. And what is the power of godliness? The blessings of the Atonement. Without the ordinances, there is no access to the blessings of the Atonement. So, even in the First Vision there’s a foreshadowing, a foretelling of priesthood and restoration and keys and ordinances that provide access to the blessings of the Atonement.', 
        'David A. Bednar - Seminar and Institute Broadcast, 2 Aug 2011', 
        false),
      Quote(
        'The Priesthood is Eternal', 
        'The Priesthood is an everlasting principle, and existed with God from eternity, and will to eternity, without beginning of days or end of years. The keys have to be brought from heaven whenever the Gospel is sent.', 
        'Joseph Smith - “The Everlasting Priesthood,” Teachings of Presidents of the Church: Joseph Smith (2011), 101.', 
        false),
      Quote(
        'Restoration of Aaronic Priesthood',
        'Upon you my fellow servants, in the name of Messiah, I confer the Priesthood of Aaron, which holds the keys of the ministering of angels, and of the gospel of repentance, and of baptism by immersion for the remission of sins; and this shall never be taken again from the earth until the sons of Levi do offer again an offering unto the Lord in righteousness.',
        'JSH 1:69',
        false
      ),
      Quote(
        'All Priesthood is Melchizedeck',
        'All priesthood is Melchizedeck; but there are different portions or degrees of it.',
        'Joseph Smith -  “Account of Meeting and Discourse, 5 January 1841, as Reported by William Clayton,” p. 5, Joseph Smith Papers',
        false
      ),
      Quote(
        'Equality of Callings',
        'There is no “up or down” in the service of the Lord. There is only “forward or backward,” and that difference depends on how we accept and act upon our releases and our callings. ',
        'Dallin H. Oaks - April 2014 Conferance - "The Keys and Authority of the Priesthood"',
        false
      ),
      Quote(
        'Relief Society a Priesthood Appendage',
        'Thus, it is truly said that Relief Society is not just a class for women but something they belong to—a divinely established appendage to the priesthood.',
        'Dallin H. Oaks - April 2014 Conferance - "The Keys and Authority of the Priesthood"',
        false
      ),
      Quote(
        'Women with Priesthood Authority',
        'We are not accustomed to speaking of women having the authority of the priesthood in their Church callings, but what other authority can it be? When a woman—young or old—is set apart to preach the gospel as a full-time missionary, she is given priesthood authority to perform a priesthood function. The same is true when a woman is set apart to function as an officer or teacher in a Church organization under the direction of one who holds the keys of the priesthood. Whoever functions in an office or calling received from one who holds priesthood keys exercises priesthood authority in performing her or his assigned duties.',
        'Dallin H. Oaks - April 2014 Conferance - "The Keys and Authority of the Priesthood"',
        false
      ),
      Quote(
        'Sustaining is essential',
        'No person is to be ordained to any office in this church, where there is a regularly organized branch of the same, without the vote of that church;',
        'D&C 20:65',
        false
      ),
      Quote(
        'Blessing of Children',
        'Every member of the church of Christ having children is to bring them unto the elders before the church, who are to lay their hands upon them in the name of Jesus Christ, and bless them in his name.',
        'D&C 20:70',
        false
      ),
      Quote(
        'Baptism Instructions',
        'The person who is called of God and has authority from Jesus Christ to baptize, shall go down into the water with the person who has presented himself or herself for baptism, and shall say, calling him or her by name: Having been commissioned of Jesus Christ, I baptize you in the name of the Father, and of the Son, and of the Holy Ghost. Amen.',
        'D&C 20:73',
        false
      ),
      Quote(
        'Prophets speak for the Lord',
        'For his word ye shall receive, as if from mine own mouth, in all patience and faith. For by doing these things the gates of hell shall not prevail against you; yea, and the Lord God will disperse the powers of darkness from before you, and cause the heavens to shake for your good, and his name’s glory.',
        'D&C 21:5-6',
        false
      ),
      Quote(
        'Priesthood ordination',
        'Every elder, priest, teacher, or deacon is to be ordained according to the gifts and callings of God unto him; and he is to be ordained by the power of the Holy Ghost, which is in the one who ordains him.',
        'D&C 20:60',
        false
      ),
      Quote(
        'Priesthood Orders',
        '''
1 There are, in the church, two priesthoods, namely, the Melchizedek and Aaronic, including the Levitical Priesthood.
2 Why the first is called the Melchizedek Priesthood is because Melchizedek was such a great high priest.
3 Before his day it was called the Holy Priesthood, after the Order of the Son of God.
4 But out of respect or reverence to the name of the Supreme Being, to avoid the too frequent repetition of his name, they, the church, in ancient days, called that priesthood after Melchizedek, or the Melchizedek Priesthood.
5 All other authorities or offices in the church are appendages to this priesthood.''',
        'D&C 107: 1-5',
        false
      ),
      Quote('Rights of Presidency', 
        'The Melchizedek Priesthood holds the right of presidency, and has power and authority over all the offices in the church in all ages of the world, to administer in spiritual things.', 
        'D&C 107:8', false),
      Quote(
        'Melchizedek Priesthood Power',
    '''
18 The power and authority of the higher, or Melchizedek Priesthood, is to hold the keys of all the spiritual blessings of the church—
19 To have the privilege of receiving the mysteries of the kingdom of heaven, to have the heavens opened unto them, to commune with the general assembly and church of the Firstborn, and to enjoy the communion and presence of God the Father, and Jesus the mediator of the new covenant.
      ''', 'D&C 107:18-19', false),
      Quote('Aaronic Priesthood Power', 
        'The power and authority of the lesser, or Aaronic Priesthood, is to hold the keys of the ministering of angels, and to administer in outward ordinances, the letter of the gospel, the baptism of repentance for the remission of sins, agreeable to the covenants and commandments.', 
        'D&C 107:20', false),
      Quote('Unanimity', 
        '''
27 And every decision made by either of these quorums must be by the unanimous voice of the same; that is, every member in each quorum must be agreed to its decisions, in order to make their decisions of the same power or validity one with the other—
28 A majority may form a quorum when circumstances render it impossible to be otherwise—
        ''', 'D&C 107:27-28', false),
      Quote('Elder\'s Quorum President', 'Again, the duty of the president over the office of elders is to preside over ninety-six elders, and to sit in council with them, and to teach them according to the covenants.', 'D&C 107:89', false),
      Quote('Dilligence in Duty', 
        '''    
99 Wherefore, now let every man learn his duty, and to act in the office in which he is appointed, in all diligence.
100 He that is slothful shall not be counted worthy to stand, and he that learns not his duty and shows himself not approved shall not be counted worthy to stand. Even so. Amen.''',
        'D&C 107:99-100', false),
      Quote(
        'Stewardship Principle',
        'It is contrary to the economy of God for any member of the Church or any one to receive instruction for those in authority higher than themselves, therefore you will see the impropriety of giving heed to them, but if any have a vision or a visitation from an hevenaly messenger it must be for their own benefit and instruction.',
        'Joseph Smith - Letter to John S. Carter, 13 April 1833, p. 30, The Joseph Smith Papers',
        false
      ),
      Quote(
        'Stewardship Principle',
        'And this shall be a law unto you, that ye receive not the teachings of any that shall come before you [without stewardship] as revelations or commandments',
        'D&C 43:5',
        false
      ),
      Quote(
        'Stewardship Principle',
        'Thou shalt not write by way of commandment [to those outside your stewardship], but by wisdom',
        'D&C 28:5',
        false
      ),
      Quote( 
        'Spirit given by prayer of faith',
        'And the Spirit shall be given unto you by the prayer of faith; and if ye receive not the Spirit ye shall not teach.',
        'D&C 42:14',
        false
      ),
      Quote( 
        'Women are Essential to the Priesthood',
        'Without the female all things cannot be restor’d to the earth. It takes all to restore the Priesthood.',
        'Knewel K. Whitney - Joseph Smith Papers, Nauvoo Relief Society Book',
        false
      ),
      Quote('Eternal Marriage', 
        '''
1 In the celestial glory there are three heavens or degrees;
2 And in order to obtain the highest, a man must enter into this order of the priesthood [meaning the new and everlasting covenant of marriage];
3 And if he does not, he cannot obtain it.''', 'D&C 131:1-2', false),
      Quote( 
        'Unity',
        'For verily I say, as ye have assembled yourselves together according to the commandment wherewith I commanded you, and are agreed as touching this one thing, and have asked the Father in my name, even so ye shall receive.',
        'D&C 42:3',
        false
      ),
      Quote( 
        'Preach by the Spirit',
        'And ye shall go forth in the power of my Spirit, preaching my gospel, two by two, in my name, lifting up your voices as with the sound of a trump, declaring my word like unto angels of God.',
        'D&C 42:6',
        false
      ),
      Quote( 
        'Healing Blessings',
        'And the elders of the church, two or more, shall be called, and shall pray for and lay their hands upon them in my name; and if they die they shall die unto me, and if they live they shall live unto me.',
        'D&C 42:44',
        false
      ),
      Quote(
        'Principle of Healing',
        '''
48 And again, it shall come to pass that he that hath faith in me to be healed, and is not appointed unto death, shall be healed.
49 He who hath faith to see shall see.
50 He who hath faith to hear shall hear.
51 The lame who hath faith to leap shall leap.
52 And they who have not faith to do these things, but believe in me, have power to become my sons; and inasmuch as they break not my laws thou shalt bear their infirmities.
        ''',
        'D&C 42:48-52',
        false
      ),
      Quote( 
        'Stewardship',
        'Thou shalt stand in the place of thy stewardship',
        'D&C 42:53',
        false
      )
    ];
  }
}

