import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/models/sql/sqlUsuario.dart';

class sqlPorakiLoginService {

  // vai ser chamado apenas na tela de Login
  Future<void> openCreateDB() async {
    String dbPath = join(await getDatabasesPath(), 'poraki');
    var db = await openDatabase(dbPath,
    version: 1,
    onCreate: (db, v) {
      db.execute(_createTableUsuarios);
      db.execute(_createTableCategories);
      db.execute(_createTableCarrinho);
      db.execute(_createTablePedidos);
      db.execute(_createTablePedidoItens);
      db.execute(_createTablePedidoMsgs);
      db.execute(_createTableEnderecos);
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

    //await db.execute("DROP TABLE Pedidos");
    //await db.execute(_createTablePedidos);

    //await db.execute("DROP TABLE PedidoItens");
    //await db.execute(_createTablePedidoItens);

    //await db.execute("DELETE FROM Pedidos");
    //await db.execute("DELETE FROM PedidoItens");

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
  final String _createTablePedidos = '''
    CREATE TABLE IF NOT EXISTS Pedidos (
    pedidoGUID TEXT,
    pedidoVendedorGUID TEXT,
    pedidoVendedorEmail TEXT,
    pedidoEm TEXT,
    pedidoValorTotal TEXT,
    pedidoFormaPagto TEXT,
    pedidoCancelada INT,
    pedidoPagtoEm TEXT,
    pedidoPessoaNome TEXT,
    pedidoPessoaEmail TEXT,
    pedidoUsuGUID TEXT,
    pedidoAval INT,
    pedidoAvalEm TEXT,
    pedidoMoeda TEXT,
    pedidoCEP TEXT,
    pedidoEndereco TEXT,
    pedidoNumero TEXT,
    pedidoCompl TEXT,
    pedidoAutoriza TEXT,
    pedidoInstituicao TEXT,
    pedidoEntregaPrevista TEXT,
    pedidoEntregaRealizadaEm TEXT,
    pedidoEntregaPorUsuEmail TEXT,
    pedidoEntregaPorUsuNome TEXT,
    pedidoEntregaDetalhe TEXT,
    pedidoDetalhe TEXT,
    pedidoRecebidoPor TEXT,
    pedidoLojaId TEXT
    );
  ''';

  // somente depois de fechada, enquanto aberta, somente da API
  final String _createTablePedidoItens = '''
    CREATE TABLE IF NOT EXISTS pedidoitens (
    pedidoItemGUID INT,
    pedidoGUID TEXT,
    ofertaGUID TEXT,
    ofertaTitulo TEXT,
    ofertaCEP TEXT,
    ofertaVendedorGuid TEXT,
    ofertaPreco REAL,
    ofertaQtd INT,
    ofertaTotal REAL,
    ofertaImgPath TEXT,
    categoriaChave TEXT,
    ofertaDetalhe TEXT,
    ofertaCanceladaEm TEXT,
    ofertaCanceladaPorNome TEXT,
    ofertaCanceladaPorEmail TEXT,
    ofertaEntregaCodigo TEXT,
    ofertaEntregueEm TEXT,
    ofertaEntreguePorNome TEXT,
    ofertaEntreguePorEmail TEXT,
    ofertaPrevisaoEntrega TEXT,
    ofertaLojaID TEXT
    );
  ''';

  // somente depois de encerrado
  final String _createTablePedidoMsgs = '''
    CREATE TABLE IF NOT EXISTS pedidoMsgs (
    pedidoGUID TEXT,
    NomeVendedor TEXT,
    NomeComprador TEXT,
    Mensagem TEXT,
    MensagemEm TEXT
    );
  ''';

  // // somente depois de fechada, enquanto aberta, somente da API
  // final String _createTablecompras = '''
  //   CREATE TABLE IF NOT EXISTS compras (
  //   compraId INT,
  //   pedidoGUID TEXT,
  //   compraVendedorGUID TEXT,
  //   compraVendedorEmail TEXT,
  //   compraEm TEXT,
  //   compraValorTotal TEXT,
  //   compraFormaPagto TEXT,
  //   compraCancelada INT,
  //   compraPagtoEm TEXT,
  //   compraPessoaNome TEXT,
  //   compraPessoaEmail TEXT,
  //   compraUsuGUID TEXT,
  //   compraAval INT,
  //   compraAvalEm TEXT,
  //   compraMoeda TEXT,
  //   compraCEP TEXT,
  //   compraEndereco TEXT,
  //   compraNumero TEXT,
  //   compraCompl TEXT,
  //   compraAutoriza TEXT,
  //   compraInstituicao TEXT,
  //   compraEntregaPrevista TEXT,
  //   compraEntregaRealizadaEm TEXT,
  //   compraEntregaPorUsuEmail TEXT,
  //   compraEntregaPorUsuNome TEXT
  //   );
  // ''';

  // // somente depois de fechada, enquanto aberta, somente da API
  // final String _createTablecompraItens = '''
  //   CREATE TABLE IF NOT EXISTS compraitens (
  //   compraId INT,
  //   pedidoGUID TEXT,
  //   ofertaId INT,
  //   ofertaTitulo TEXT,
  //   ofertaCEP TEXT,
  //   ofertaVendedorId INT,
  //   ofertaPreco REAL,
  //   ofertaQtd INT,
  //   ofertaTotal REAL,
  //   ofertaImgPath TEXT,
  //   categoriaChave TEXT,
  //   ofertaCancelada INT,
  //   ofertaEntregueEm TEXT
  //   );
  // ''';

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
    mofertaCancelada INT,
    mofertaDispoAte TEXT,
    mofertaTempoDeEntrega
    );
  ''';


  // Tipos de Endereços: Home / Work / School / Others
  final String _createTableEnderecos = '''
    CREATE TABLE IF NOT EXISTS enderecos (
    enderecoGuid TEXT,
    usuEmail TEXT,
    usuGuid TEXT,
    enderecoCEP TEXT,
    enderecoLogra TEXT,
    enderecoNumero TEXT,
    enderecoCompl TEXT,
    enderecoTipo TEXT,
    enderecoAtual TEXT,
    enderecoUltData TEXT
    enderecoDesde TEXT,
    enderecoLatitude TEXT,
    enderecoLongitude TEXT
    );
  ''';

  // tempo de Entrega igual ao Jira
// caracteristicas separado por ;
// qtd vendidos
// marca, cores, tamanhos, peso/porcao, voltagem, material, sabor, ano, unidade, validade
// unidades de serviço: valor por serviço / hora

// disponibilidade:
// 24hs
// marcar dias da semana
// horario de anuncio - de/ate (no caso de serviços, horario de funcionamento)
// horario de entrega - de/ate

// forma de fechamento - compra por aplicativo ou contato

// formas de entrega - eu entrego/pelo vendedor, comprador retira, parceiro (mostra nome do parceiro disponivel + valor ou indisponivel)
// caso seja eu mesmo entrego, adicionar valor fixo da entrega até 1km, entre 1 e 2km, acima de 2km
// fotos - foto principal + fotos adicionais (+3)
// mostrar avaliações dos outros clientes S/N
// valor do orçamento
// opcao de pagar sinal pra encomenda
// para aceitar pagamentos ou se for lojinha, tem q passar por avaliacao civil



}