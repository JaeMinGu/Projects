package kr.or.kosta.blog.article;

import java.util.List;

import kr.or.kosta.blog.common.Params;

public interface ArticleDao {

	/** 게시글 작성 후 등록하기 */
	public void create(Article article) throws Exception;
	
	/** 게시글 반환하기 */
	public Article read(int articleId) throws Exception; 

	/** 게시글 수정하기 */
	public void update(Article article) throws Exception; 
	
	/** 게시글 삭제하기 */
	public void delete(String article_id) throws Exception;
	
	/** 게시글 전체리스트 보여주기*/
	public List<Article> listAll() throws Exception;
	
	/** 첫 번째 댓글 등록하기 */
	public boolean reply(Article article) throws Exception; 
	
	/** 페이징 정렬하기 */
	public List<Article> listByPage(Params param) throws Exception; 
	
	/** 카운트하기 */
	public int countBySearch(Params params) throws Exception;

}
