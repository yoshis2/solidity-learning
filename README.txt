REMIX DEFAULT WORKSPACE

Remixのデフォルトのワークスペースが存在する場合：
i. Remixが初めてロードされたとき 
ii. 新しいワークスペースが'Default'テンプレートで作成される。
iii. ファイルエクスプローラーにファイルはありません。

このワークスペースには3つのディレクトリがあります：

1. contract'： 複雑さを増す3つの契約を保持する。
2. scripts'： コントラクトをデプロイするための4つのタイプスクリプトファイルが格納されている。以下に説明する。
3. 'tests'： Ballot' コントラクト用の Solidity テストファイルと 'Storage' コントラクト用の JS テストファイルが含まれます。

スクリプト

scripts'フォルダには、'web3.js'と'ethers.js'ライブラリを使用して'Storage'コントラクトをデプロイするのに役立つ4つのtypescriptファイルがあります。

他のコントラクトをデプロイするには、コントラクトの名前を'Storage'から目的のコントラクトに変更し、コンストラクタの引数を指定します。
ファイル `deploy_with_ethers.ts` または `deploy_with_web3.ts` に記述します。

tests' フォルダには 'Storage' コントラクト用の Mocha-Chai ユニットテストを含むスクリプトがある。

スクリプトを実行するには、ファイルエクスプローラーでファイル名を右クリックし、'Run' をクリックします。Solidity ファイルは既にコンパイルされている必要があります。
スクリプトからの出力はリミックスターミナルに表示されます。


なお、require/importはRemixがサポートしているモジュールに対して限定的にサポートされています。
今のところ、Remixがサポートしているモジュールは、ethers、web3、swarmgw、chai、multihashes、remix、そしてhardhat.ethers object/pluginのみです。
サポートされていないモジュールの場合、次のようなエラーが表示されます: '<モジュール名> module require is not supported by Remix IDE'。



