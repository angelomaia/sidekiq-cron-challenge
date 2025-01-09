## Desafio de Sidekiq e Cron

1. **Pré-requisitos para o tópico:**
- *Conhecimento em Ruby*
- *Conhecimento em Docker*
1. **Introdução:**

Este desafio contempla o fluxo de expiração de senhas de caixas de email em uma API backend, simulando um fluxo que acontece em projetos reais mas com um escopo muito mais reduzido, focando no aprendizado das ferramentas.

1. **Referências para estudo:**

- [Hash Data in Ruby](http://geekhmer.github.io/blog/2015/04/18/hash-data-in-ruby/)
- [What is difference between Encryption and Hashing?](https://www.encryptionconsulting.com/education-center/encryption-vs-hashing/)
- [Crontab Guru](https://crontab.guru/)
- [Rails Cron Jobs — Task Scheduling In Rails](https://medium.com/@hasnatraza.dev/rails-cron-jobs-task-scheduling-in-rails-f7662106feaa)
- [Site oficial Sidekiq](https://sidekiq.org/)
- [Sidekiq gem](https://github.com/sidekiq/sidekiq)

1. **Descrição do desafio:**

Esta atividade deverá ser feita individualmente e tem como requisito a utilização de Ruby, Sidekiq, Redis e CronJob, tudo sendo executado através de Docker. O desafio aborda a construção de uma API backend que gerencia domínios e caixas de email. Recomenda-se a utilização de Ruby on Rails e PostgreSQL, mas caso tenha interesse em realizar com outro framework/banco de dados não há problema.

1. **Regras**
- Regras de negócio
    
    Na sequência estão todos os “critérios de aceite” do desafio:
    
    - A aplicação gerencia domínios e caixas de email.
    - Um domínio pode possuir várias caixas de email.
    - Uma caixa de email pertence à um domínio.
    - Cada domínio possui uma frequência de expiração de senha das caixas em dias(a cada 30, 60, 90, 180 dias).
    - Cada caixa de email possui uma expiração de senha agendada, que é atualizada baseada na frequência.
    - Quando a data de expiração de uma caixa é "atingida" sua senha deve ser expirada(atualizada para um outro valor aleatório qualquer).
    - As senhas das caixas não podem ser salvas como texto plano no banco de dados, devem ser salvas em formato "Hash"(por exemplo SHA-512).
    - Sempre que uma caixa de email tem sua senha é alterada, a sua data de expiração deve ser atualizada para a data atual + os dias da frequência de expiração do domínio.
- Modelagem dos dados
    
    A modelagem dos dados é livre contanto que cumpra todas as regras de negócio, segue um modelo para auxílio:
    
    ```
    * Domain
    	- domain_name:String
    	- password_expiration_frequency:Int
    * Mailbox
    	- domain_id:Int
    	- username:String
    	- password:String
    	- scheduled_password_expiration:Date
    ```
    
- Requisitos da aplicação
    - A aplicação deve possuir pelo menos um endpoint para update do recurso “mailbox”:
        - `PUT /domains/:domain_id/mailboxes/:mailbox_id`
    - Essa rota deve fazer o update da senha da caixa de email. Essa rota é a única obrigatória mas desejar pode fazer as outras rotas do CRUD seguindo a convenção REST.
    - A aplicação deve possuir uma configuração de Cron Job para executar o processo diariamente, esse processo deve selecionar todas as caixas que estejam com expiração de senha "vencidas" e chamar um job do Sidekiq para realizar a atualização das senhas dessas caixas.
    - Bônus: É muito importante que a aplicação possua uma boa cobertura de testes unitários.