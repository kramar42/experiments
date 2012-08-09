import java.util.ArrayList;

public class Graph
{
	int [][] data;
	int [] weights;
	boolean [] visited;
	ArrayList<Integer> path;
	
	public Graph()
	{
		this(Dijkstra.GRAPH_SIZE);
	}
	
	public Graph(int size)
	{
		data = new int [size][size];
		weights = new int [size];
		visited = new boolean[size];
		path = new ArrayList<Integer>();
	}
	
	public void addEdge(int i, int j, int weight)
	{
		data[i][j] = data[j][i] = weight;
	}
	
	public void calculateMinimums(int from, int to)
	{
		for (int i = 0; i < weights.length; ++i)
		{
			weights[i] = Dijkstra.INFINITY;
		}
		weights[from] = 0;
		
		int current = from;
		
		while (current != to)
		{
			for (int i = 0; i < data[current].length; ++i)
			{
				if (data[current][i] != 0 && !visited[i])
				{
					int newWeight = weights[current] + data[current][i];
					weights[i] = newWeight < weights[i] ? newWeight : weights[i];
				}
			}
			visited[current] = true;
			
			// Finding next vertex with smallest weight
			int next = to;
			for (int i = 0; i < weights.length; ++i)
			{
				// But not zero & not visited yet
				if (weights[i] <  weights[next] && weights[i] != 0 && !visited[i])
				{
					next = i;
				}
			}
			
			current = next;
		}
	}
	
	public int [] findPath(int from, int to)
	{
		calculateMinimums(from, to);
		
		int prev = to;
		while (prev != from)
		{
			path.add(prev);
			for (int i = 0; i < weights.length; ++i)
			{
				if (data[i][prev] != 0 && weights[i] + data[i][prev] == weights[prev])
				{
					prev = i;
				}
			}
		}
		path.add(from);
		Integer[] integerPath = path.toArray(new Integer[path.size()]);
		int [] returnPath = new int [path.size()];
		for (int i = 0; i < returnPath.length; ++i)
		{
			returnPath[i] = integerPath[returnPath.length - i - 1].intValue();
		}
		
		return returnPath;
	}
}
