# Sentimento
## (análise de sentimento das atas do COPOM)

Meste projeto eu tento de forma didática e reprodutível fazer a análise de sentimento das atas do COPOM, documentos do Banco Central do Brasil que analisam a política de metas de inflação e justificam as mudanças nas metas da taxa de juros básica (SELIC).

### Arquivos:
* functions.R: são as funções que são utilizadas na análise, incluindo extrair textos dos pdfs e hmtls, pontuar arquivos e listas de acordo com a análise de sentimento, etc.
* downloader.R: função e comando que faz o download das atas do site do Banco Central e salva na pasta (atas). Necessário ter rodado este arquivo para construir a base com o próximo arquivo, se desejar.
* builder.R: Utiliza as funções do arquivos functions e os arquivos baixados com o downloader para construir uma tabela com os números das atas, datas de publicação e textos completos e salvar em um arquivo no formato texto.
* leitor.R: Comandos para, tendo baixado o arquivo atas.txt criado pelo builder, reconstruir a tabela no R para ser utilizada nas análises.
* sentimento.R: Análise simples de sentimento.
* graph.R: Cria um gráfico histórico de linhas com a análise de sentimento da base de dados. Precisa ter usado o leitor primeiro.