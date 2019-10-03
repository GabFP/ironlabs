/*--------------------Challenge-1--------------------------------------*/
SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, titles.title, publishers.pub_name as publichers
FROM authors, titles, publishers, titleauthor
WHERE publishers.pub_id = titles.pub_id AND titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id


/*--------------------Challenge-2--------------------------------------*/

SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, publishers.pub_name as publichers, COUNT(*) AS title_count
FROM authors, titles, publishers, titleauthor
WHERE publishers.pub_id = titles.pub_id AND titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id
GROUP BY author_id, last_name, first_name, publichers
ORDER BY title_count DESC;


/*--------------------Challenge-3--------------------------------------*/

SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, SUM(sales.qty) AS total
FROM authors, titles, titleauthor, sales
WHERE titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id AND titles.title_id = sales.title_id
GROUP BY author_id, last_name, first_name
ORDER BY total DESC
LIMIT 3;

/*--------------------Challenge-4--------------------------------------*/

SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, SUM(COALESCE(sales.qty, 0)) AS total
FROM authors
LEFT JOIN titleauthor ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY author_id, last_name, first_name
ORDER BY total DESC

/*--------------------Challenge-5--------------------------------------*/

SELECT auid, SUM(royals) as proffit
FROM(SELECT auth_title_royal.author_id AS auid, auth_title_royal.title_id AS tid, SUM(sales_royalty) AS royals
	FROM(SELECT authors.au_id AS author_id, titles.title_id, titles.price::FLOAT * sales.qty::FLOAT * titles.royalty::FLOAT / 100 * titleauthor.royaltyper / 100 AS sales_royalty
		FROM authors, titles, titleauthor, sales
		WHERE titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id AND titles.title_id = sales.title_id) AS auth_title_royal
	GROUP BY author_id, title_id) as royal_author
GROUP BY auid
ORDER BY proffit DESC
LIMIT 3

/*--------------------Challenge-6--------------------------------------*/

SELECT authors.au_id AS author_id, titles.title_id, titles.price::FLOAT * sales.qty::FLOAT * titles.royalty::FLOAT / 100 * titleauthor.royaltyper / 100 AS sales_royalty
INTO TEMP TABLE auth_title_royal
FROM authors, titles, titleauthor, sales
WHERE titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id AND titles.title_id = sales.title_id

SELECT auth_title_royal.author_id AS auid, auth_title_royal.title_id AS tid, SUM(sales_royalty) AS royals
INTO TEMP TABLE royal_author
FROM auth_title_royal
GROUP BY author_id, title_id

SELECT auid, SUM(royals) as proffit
FROM royal_author
GROUP BY auid
ORDER BY proffit DESC
LIMIT 3

/*--------------------Challenge-7--------------------------------------*/

SELECT auid AS au_id, SUM(royals) as proffit
INTO TABLE most_profiting_authors
FROM royal_author
GROUP BY auid
ORDER BY proffit DESC
LIMIT 3

SELECT * FROM most_profiting_authors
