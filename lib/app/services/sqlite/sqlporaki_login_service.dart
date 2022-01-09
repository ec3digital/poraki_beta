import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlUsuario.dart';

class sqlPorakiLoginService {

  // vai ser chamado apenas na tela de Login
  Future<void> openCreateDB() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath,
    version: 1,
    onCreate: (db, v){
      db.execute(_createTableUsuarios);
      db.execute(_createTableCategories);
      db.execute(_createTableCarrinho);

    });

    var usu = await buscaUsuDados();
    if (usu.isEmpty)
      await insertUsuarioDefault();

    await db.close();
  }

  Future<List<Map<String,dynamic>>> buscaUsuDados() async {
    String path = join( await getDatabasesPath(), 'poraki');
    Database db = await openDatabase(
        path,
        version: 1,
    );
    return db.query('usuarios');
  }

  Future<void> deleteUsuario() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    await db.delete('usuarios');

    await db.close();
  }

  Future<void> reinsertUsuario(sqlUsuarios usuario) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    await db.insert('usuarios', usuario.toMapBasic());

    await db.close();
  }

  Future<void> insertUsuarioDefault() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    sqlUsuarios usuarios = new sqlUsuarios("seuMelhorEmail@dominio.com",".",".",".",".","05735-030",".",".",".",".","","1.0");

    await db.insert('usuarios', usuarios.toMap());

    await db.close();
  }

  Future<void> insertUsuario(sqlUsuarios usuario) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);
    //sqlUsuarios usuarios = new sqlUsuarios("seuMelhorEmail@dominio.com",".",".",".",".","05735-030",".",".",".",".","","1.0");

    db.insert('usuarios', usuario.toMap());

    await db.close();
  }

  Future<void> updateUsuario(sqlUsuarios usuario) async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath, version: 1);

    await db.update('usuarios', usuario.toMap(), where: "usuEmail = ?", whereArgs: [usuario.usuEmail]);

    await db.close();
  }

  // pra ver se a tabela de usuários existe
  final String _verificaTabelaUsuarios = '''
  SELECT * FROM sqlite_master WHERE name ='usuarios' and type='table'; 
  ''';

  //cria na tela de login
  final String _createTableUsuarios = '''
    CREATE TABLE IF NOT EXISTS usuarios (
    usuEmail TEXT PRIMARY KEY,
    usuNome TEXT,
    usuSobreNome TEXT,
    usuCPF TEXT,
    usuTelefone TEXT,
    usuCEP TEXT,
    usuEndereco TEXT,
    usuNumero TEXT,
    usuCompl TEXT,
    usuLastLogin TEXT,
    usuTermosEm TEXT,
    usuVersao TEXT
    );
  ''';

  // cria no sucesso do login
  final String _createTableCategories = '''
    CREATE TABLE IF NOT EXISTS categorias (
    categoriaChave TEXT PRIMARY KEY,
    categoriaNome TEXT,
    secao TEXT,
    mostraBarra INT,
    iconCode INT
    );
  ''';

  //cria no sucesso do login
  final String _createTableCarrinho = '''
    CREATE TABLE IF NOT EXISTS carrinho (
    ofertaId INT,
    ofertaTitulo TEXT,
    ofertaCEP TEXT,
    ofertaVendedorId INT,
    ofertaPreco REAL,
    ofertaQtd INT,
    ofertaImgPath TEXT,
    categoriaChave TEXT,
    ofertaEntregaPrevEm TEXT
    );
  ''';


  // cria no momento da criação do usuario
  final String _createTableUsuarioConfig = '''
    CREATE TABLE IF NOT EXISTS usuariocfg (
    usuEmail TEXT,
    configChave TEXT,
    configValor TEXT,
    configAtiv INT
    );
  ''';

  // cria quando entra no app - Wave 2 (trazer o script direto da API)
  final String _createTableDiconario = '''
    CREATE TABLE IF NOT EXISTS dicionario (
    dicValor TEXT,
    dicChave TEXT,
    dicTela TEXT
    );
  ''';

  // cria no momento da criação do usuario
  final String _createTableVendFav = '''
    CREATE TABLE IF NOT EXISTS vendfavs (
    vendGuid TEXT,
    vendNome TEXT
    );
  ''';

  // cria no momento da criação do usuario
  final String _createTableVendedor = '''
    CREATE TABLE IF NOT EXISTS vendedor (
    vendGuid TEXT,
    vendNome TEXT,
    vendCEP TEXT
    );
  ''';

  // cria no momento da criação do usuario
  final String _createTableLojasFav = '''
    CREATE TABLE IF NOT EXISTS lojasfavs (
    lojaGUID TEXT,
    lojaNome TEXT
    );
  ''';

  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTableVendas = '''
    CREATE TABLE IF NOT EXISTS vendas (
    vendaId INT,
    pedidoGUID TEXT,
    vendaVendedorGUID TEXT,
    vendaVendedorEmail TEXT,
    vendaEm TEXT,
    vendaValorTotal TEXT,
    vendaFormaPagto TEXT,
    vendaCancelada INT,
    vendaPagtoEm TEXT,
    vendaPessoaNome TEXT,
    vendaPessoaEmail TEXT,
    vendaUsuGUID TEXT,
    vendaAval INT,
    vendaAvalEm TEXT,
    vendaMoeda TEXT
    vendaCEP TEXT,
    vendaEndereco TEXT,
    vendaNumero TEXT,
    vendaCompl TEXT,
    vendaAutoriza TEXT,
    vendaInstituicao TEXT,
    vendaEntregaPrevista TEXT,
    vendaEntregaRealizadaEm TEXT,
    vendaEntregaPorUsuEmail TEXT,
    vendaEntregaPorUsuNome TEXT
    );
  ''';

  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTableVendaItens = '''
    CREATE TABLE IF NOT EXISTS vendaitens (
    vendaItemId INT,
    vendaId INT,
    pedidoGUID TEXT,
    ofertaId INT,
    ofertaTitulo TEXT,
    ofertaCEP TEXT,
    ofertaVendedorId INT,
    ofertaPreco REAL,
    ofertaQtd INT,
    ofertaTotal REAL,
    ofertaImgPath TEXT,
    categoriaChave TEXT,
    ofertaCancelada INT,
    ofertaEntregueEm TEXT
    );
  ''';

  // somente depois de encerrado
  final String _createTablePedidoMsgs = '''
    CREATE TABLE IF NOT EXISTS vendasmsgs (
    pedidoGUID TEXT,
    NomeVendedor TEXT,
    NomeComprador TEXT,
    Mensagem TEXT,
    MensagemEm TEXT
    );
  ''';

  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTablecompras = '''
    CREATE TABLE IF NOT EXISTS compras (
    compraId INT,
    pedidoGUID TEXT,
    compraVendedorGUID TEXT,
    compraVendedorEmail TEXT,
    compraEm TEXT,
    compraValorTotal TEXT,
    compraFormaPagto TEXT,
    compraCancelada INT,
    compraPagtoEm TEXT,
    compraPessoaNome TEXT,
    compraPessoaEmail TEXT,
    compraUsuGUID TEXT,
    compraAval INT,
    compraAvalEm TEXT,
    compraMoeda TEXT,
    compraCEP TEXT,
    compraEndereco TEXT,
    compraNumero TEXT,
    compraCompl TEXT,
    compraAutoriza TEXT,
    compraInstituicao TEXT,
    compraEntregaPrevista TEXT,
    compraEntregaRealizadaEm TEXT,
    compraEntregaPorUsuEmail TEXT,
    compraEntregaPorUsuNome TEXT
    );
  ''';

  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTablecompraItens = '''
    CREATE TABLE IF NOT EXISTS compraitens (
    compraId INT,
    pedidoGUID TEXT,
    ofertaId INT,
    ofertaTitulo TEXT,
    ofertaCEP TEXT,
    ofertaVendedorId INT,
    ofertaPreco REAL,
    ofertaQtd INT,
    ofertaTotal REAL,
    ofertaImgPath TEXT,
    categoriaChave TEXT,
    ofertaCancelada INT,
    ofertaEntregueEm TEXT
    );
  ''';

  // cria no momento de acesso ao menu anúncios
  // mofertaDispoDesde poderá ser nullada pra alterar disponibilidade
  final String _createTableMOfertas = '''
    CREATE TABLE IF NOT EXISTS mofertas (
    mofertaId INT,
    mofertaTitulo TEXT,
    mofertaDetalhe TEXT,
    mofertaDispoDesde TEXT,
    mofertaCEP TEXT,
    mofertaPreco REAL,
    mofertaQtd INT,
    mofertaImgPath TEXT,
    mcategoriaChave TEXT,
    mofertaCancelada INT
    );
  ''';

}