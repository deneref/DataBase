## Дополнительное задание
Дана таблица вида 

| id работника      |  код прогула |  дата прогула |
| ----------------- | ------------ |  ------------ |
|         1         |      4       | '2012.04.12'  |
|         2         |      6       | '2012.04.13'  |
|         1         |      4       | '2012.04.13'  |
|         1         |      4       | '2012.04.14'  |
|         ...       |      ...     |     ...       |

Привести таблицу к следующему виду

| id работника      |  код прогула |  дата прогула |
| ----------------- | ------------ |  ------------ |
|         1         |      4       | '2012.04.12'  |
|         1         |      4       | '2012.04.14'  |
|         2         |      6       | '2012.04.13'  |
|         ...       |      ...     |     ...       |